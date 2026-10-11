# Mathematica Analytical Model

This folder contains my analytical investigation of environment-assisted
quantum transport using Mathematica.

The notebooks study simplified finite quantum networks and derives closed
expressions for transport efficiency under different physical limits
('limit_analysis.nb'). 
Additionally, the Taylor expansions of efficiency were explored in different 
regimes in 'taylor_expansions.nb'.

## Explanation of files

For both files the “Building Hamiltonian” block is an initialisation block and 
it should be set to run every time you open the file. 'limits_analysis.nb' is all the 
limits on different variables, given different energy landscapes separated in blocks. 
The user should be able to test the individual models using their respective blocks. 

The second file 'taylor_expansions.nb' is the Taylor expansions of the final efficiency,
in 1/gd, gd and v_2. The code runs given an energy landscape 'eff' set by the user.
(I did not separate the different models by section, but instead you can 
set “eff = (model)” in the second initialisation blocks under “Energy Model”)

## Examples of Limits Studied

The notebook investigates regimes including

- vanishing nearest-neighbour coupling,
- vanishing next-nearest-neighbour coupling,
- weak decoherence,
- weak leakage,
- strong nearest-neighbour coupling,

## Example Physical Insights

Several limiting cases show that energetic separation between sites can reduce
transport efficiency, while intermediate environmental interaction can produce
a maximum in transport rather than a monotonic decrease.

The analytical model therefore provides intuition for the competing effects of

coherent coupling, localisation / transport

environmental interaction → coherence loss but potentially improved transport

strong environmental interaction → transport suppression



The calculations in this notebook were developed independently as part of my
undergraduate research in quantum transport.
