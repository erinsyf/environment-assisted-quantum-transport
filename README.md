# Environment-Assisted Quantum Transport

Numerical and analytical investigation of environment-assisted quantum transport (ENAQT) in disordered quantum networks using open quantum-system dynamics.

This project originated from my undergraduate research in quantum transport at the University of Toronto. I investigate how environmental decoherence, energetic disorder, long-range coupling, and extraction affect excitation transport through finite quantum networks.

## Motivation

Quantum coherence can enable excitation transport through coupled quantum systems, but disorder can also lead to localization and suppress transport.

Interaction with an environment is therefore not always purely detrimental. In certain regimes, moderate decoherence can disrupt localization and improve transport — a phenomenon known as **environment-assisted quantum transport (ENAQT)**.

The main question: 

> **Under what conditions can environmental noise enhance, rather than suppress, quantum transport?**

## Physical Model

The system is represented as a finite network of coupled sites with Hamiltonian

$$
H =
\sum_i \epsilon_i |i\rangle\langle i|
+
\sum_{i\neq j} V_{ij}|i\rangle\langle j|,
$$

where

- $\epsilon_i$ represents the energy of site $i$,
- $V_{ij}$ represents coherent coupling between sites $i$ and $j$,
- energetic disorder is introduced through variations in $\epsilon_i$.

For the numerical model, long-range interactions are approximated using a power-law relation:

$$
V_{ij} =
\frac{V_{\max}}{|i-j|^\alpha}.
$$

The density matrix evolves according to an open-system master equation,

$$
\frac{d\rho}{dt}
=
-i[H,\rho]
+
\mathcal{D}(\rho)
$$

where $\mathcal{D}(\rho)$ describes environmental decoherence and extraction (set leakage rate) from the network.

## Numerical Simulation

The original numerical implementation was developed in MATLAB.

The simulation:

1. generates a finite disordered quantum network,
2. constructs the system Hamiltonian,
3. represents the master equation as a Liouvillian acting on the vectorized density matrix,
4. propagates the density matrix in time,
5. varies the environmental decoherence rate,
6. evaluates transport using the population of a selected output site over a fixed time interval.

The model allows the competition between coherent transport, localization, environmental decoherence, and extraction to be studied directly.

## Analytical Model

A complementary Mathematica model was developed for a smaller quantum network.

Symbolic expressions were derived and explored under several limiting regimes, including

- vanishing nearest-neighbour coupling,
- vanishing next-nearest-neighbour coupling,
- weak decoherence,
- weak extraction,
- strong coupling,
- energetic detuning between sites.

These limits provide intuition for when environmental interactions enhance transport and when they instead suppress it.

## Key Physical Insight

The important competition can be summarized as

$$
\text{disorder}
\rightarrow
\text{localization}
$$

while moderate environmental interactions can disrupt localization:

$$
\text{localization}
\xrightarrow{\text{moderate decoherence}}
\text{enhanced transport}.
$$

However, sufficiently strong environmental interaction suppresses useful coherent dynamics.

This produces the characteristic ENAQT idea that **optimal transport can occur at an intermediate environmental coupling strength rather than in the completely isolated limit.**

## Repository Structure

```text
environment-assisted-quantum-transport/
│
├── README.md
├── matlab/
├── mathematica/
├── python/
├── figures/
└── docs/
