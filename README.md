# Neutron Coincidence Counter
Some radioactive materials undergo spontaneous fission reactions causing them to release one or more neutrons spontaneously per reaction. 
Knowing the number of these coincidence neutron events, quantitative estimation of radioactive material can be performed non-destructively and safely.
Neutron detectors are used to give electrical pulse signals for each neutron detected. However, gross counting of neutrons do not provide the exact representation of
coincidence neutrons emitted spontaneously due to fission reactions as there are background neutrons and coincidence events can also be wrongly accounted due to
neutrons not emmited spontaneously. Neutron counts after a random event follows Rossi Alpha Distribution. The provided code is the synthesizable  RTL description of a digital circuit which can be used to estimate real coincidence counts by using the Rossi Alpha Distribution.
## I/O Description
- i_clk_1mhz		: Clock frequency of 1MHz
- i_pulse_signal	: Input pulse signal from neutron detectors
- i_reset			: Reset signal to reset internal registers / counters to zero
- o_r_plus_a_count	: Binary value of total calculated coincidence counts i.e. both real plus accidental coincidence events
- o_a_count			: Binary value of total calculated accidental coincidence counts
- o_total_count		: Binary value of total detected neutrons
