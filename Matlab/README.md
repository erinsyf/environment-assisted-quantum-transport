# MATLAB ENAQT Simulation

Independent MATLAB implementation of quantum transport through a finite network of coherently coupled sites subject to energetic disorder, environmental dephasing, and population extraction.

The code is designed to be configurable: users can modify the system parameters at the top of the script to explore different transport regimes.

## Physical Model

The system consists of N sites representing localized excitation states

The Hamiltonian is

$$
H =
\sum_i E_i |i\rangle\langle i|
+
\sum_{i\neq j} V_{ij}|i\rangle\langle j|
$$

where:

- $E_i$ is the energy of site $i$,
- $V_{ij}$ is the coherent coupling between sites.

The interaction strength is modelled using a distance-dependent power law explained in the main description.

Energetic disorder can be introduced by assigning different values to the site energies $E_i$.

## Open-System Dynamics

The density matrix evolves according to the Lindblad master equation. The coherent part is constructed element-by-element from

$$
\dot{\rho}_{ij} = -i\sum_k H_{ik}\rho_{kj} + i\sum_k \rho_{ik}H_{kj}
$$

and the resulting equations are stored in an $N^2\times N^2$ Liouvillian matrix, 
after vectorising the density matrix.

## Environmental Dephasing

Pure dephasing suppresses off-diagonal density-matrix elements while leaving populations unchanged directly.

For $i\neq j$, the off diagonal components gain a term: 

$
-\gamma_d \rho_{ij}
$

where $\gamma_d$ is the dephasing rate.

## Output-Site Leakage

Population is extracted at leakage rate $\gamma_l$.

So the output-site population therefore contains the loss term 
$
-\gamma_l \rho_{oo}
$

while coherences in off diagonal terms coupled to the output site decay as

$
-\frac{\gamma_l}{2}\rho_{oj}
$

## Simulation Modes

The script supports two calculation modes - dynamic and steady state


## Efficiency Calculations

Note that For the dynamical simulations, transport performance is quantified by the time-averaged population of the output site over the characteristic transport timescale 
$T_I=N/V_{\max}$, 
following the metric used in the underlying research model developed by the research group.
