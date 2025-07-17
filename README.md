# Neutron Coincidence Counter
Some fissile materials undergo spontaneous fission reactions causing them to release one or more neutrons spontaneously per reaction. 
Knowing the number of these coincidence neutron events, quantitative estimation of radioactive material can be performed non destructively and safely.
Neutron detectors are used to give pulse signals for each detected neutron. However, gross counting of neutrons do not give the number of
coincidence neutrons emitted spontaneously due to fission reactions as there is background neutrons and coincidence can be accounted due to
other neutrons not emmited spontaneously. Neutron counts after a random event follows Rossi Alpha Distribution. The provided code is the RTL
equivalent of a digital circuit which can be used to estimate real coincidence counts by using the Rossi Alpha Distribution.
## I/O Description
- i_clk_1mhz		: Clock frequency of 1MHz
- i_pulse_signal	: Input pulse signal from neutron detectors
- i_reset			: Reset signal to reset internal registers / counters to zero
- o_r_plus_a_count	: Binary value of total calculated coincidence counts i.e. both real plus accidental coincidence events
- o_a_count			: Binary value of total calculated accidental coincidence counts
- o_total_count		: Binary value of total detected neutrons
