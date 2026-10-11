%% Environment-Assisted Quantum Transport

%% User-defined system parameters

num_sites = 4;

site_energies = [0.1, 0.2, 0.3, 0.1];

coupling_scale = 0.4; % this is V_max
coupling_exponent = 1.2; % this is alpha

input_site = 1;
output_site = num_sites;

dephasing_rate = 0.1; % Gamma
leakage_rate = 0.1; % gamma_l

simulation_mode = "steady_state";   % "dynamics" or "steady_state"


%% Construct system Hamiltonian

H = diag(site_energies); % First add diagonal energies on each site

% Add distance-dependent coherent couplings between distinct sites
for i = 1:num_sites
    for j = 1:num_sites

        if i ~= j % no coupling on sites themselves
        
            distance = abs(i - j);
            coupling = coupling_scale / distance^coupling_exponent;

            H(i, j) = coupling;
        end
    end
end

% Preview matrix

fprintf('Hamiltonian constructed:\n')
disp(H)

%% Initialise density matrix -> vector

rho_0 = zeros(num_sites); % initial density matrix 

rho_0(input_site, input_site) = 1; % put excitation at the input site

% Now we want to vectorise it rho_0 = (rho_11, rho_12,....rho_21,
% rho_22...rho_NN) 

rho_0_vector = reshape(rho_0.', [], 1); % stack the rows together


%% Initialise Liouvillian L

L = zeros(num_sites^2, num_sites^2);

for i = 1:num_sites % iterate through values of rho_ij
    for j = 1:num_sites
        
        % Row corresponding to the equation d(rho_ij)/dt
        row = (i - 1) * num_sites + j; 

        % Add dephasing elements only to off diagonal components of rho

        if i ~= j 
            
            % row - d/dt rho_ij and column rho_ij are same 
    
            L(row, row) = L(row,row) - dephasing_rate;

        end

        % Add leakage on the exit site

        if i == output_site && j == output_site

            % Output-site population leaks out
            L(row,row) = L(row,row) - leakage_rate;

        elseif i == output_site || j == output_site

            % Coherence from output site
            L(row,row) = L(row,row) - leakage_rate/2;

        end
        
        % Add coherent contributions from -i[H, rho]
        % Sum over intermediate index k in the commutator [H,rho]

        for k = 1:num_sites 

            % contribution -iH_ik*rho_kj

            column = (k - 1)*num_sites + j; % column corresponding to rho_kj 

            L(row, column) = L(row, column) - 1i*H(i,k);

            % contribution +i*rho_ik*H_kj
            column = (i - 1) * num_sites + k; % column corresponding to rho_ik 

            L(row, column) = L(row, column) + 1i * H(k,j);

        end
    end
end


rho_dot_vector = L * rho_0_vector;

% convert back to matrix form 

rho_dot_matrix = reshape(rho_dot_vector, num_sites, num_sites).';

%% Run simulations


if simulation_mode == 'dynamics'

    % Timescales (user can tweak parameters)

    dt = 0.4;
    final_time = 100;

    times = 0:dt:final_time;

    % initialise list of density matrices at some time 
    rho_t = zeros(num_sites, num_sites, length(times));

    for t_index = 1:length(times)

        t = times(t_index);

        rho_vector_t = expm(L*t) * rho_0_vector; % propagate the vector

        % Convert row-stacked vector back to density matrix
        rho_t(:,:,t_index) = reshape(rho_vector_t, num_sites, num_sites).';

    end

    % Plot site populations over time
    figure;
    hold on;

    for site = 1:num_sites

        population = real(squeeze(rho_t(site,site,:)));

        plot(times, population,'DisplayName', sprintf('Site %d', site));

    end

    xlabel('Time');
    ylabel('Population');
    title('Population Dynamics');
    grid on;
    legend('Location', 'best');

    hold off;

    % Calculate Efficiency
    time_average = num_sites / coupling_scale; % Time to average over for flux calculation
    steps = ceil(time_average / dt);

    output_population = real(squeeze(rho_t(output_site, output_site, :)));

    efficiency_dynamic = sum(output_population(1:steps))* dt / time_average;

elseif simulation_mode == 'steady_state'

    % To satisfy trace preservation we need to modify the Liouvillian

    L_ss = L;

    L_ss(1, :) = 0;

    % Replace elements in the first row corresponding to diagonal sites 
    % rho_ii with 1

    for i = 1:num_sites
        indices = (i-1)*num_sites + i;
        L_ss(1, indices) = 1;
    end

    % Right-hand side
    v = zeros(num_sites^2,1); % vector (1, 0, 0, 0..,0) for steady state
    v(1) = 1;

    % Solve
    rho_ss_vector = L_ss \ v;

    % Reconstruct density matrix
    rho_ss = reshape(rho_ss_vector, num_sites, num_sites).';
    
    fprintf('Steady State density Matrix:\n')
    disp(rho_ss)

    % Calculate efficiency
    output_population_ss = real(rho_ss(output_site, output_site));
    efficiency_steady_state = leakage_rate * output_population_ss;

    
end
