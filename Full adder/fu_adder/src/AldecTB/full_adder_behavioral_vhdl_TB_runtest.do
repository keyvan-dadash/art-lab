SetActiveLib -work
comp -include "$dsn\src\full_adder.vhd" 
comp -include "$dsn\src\AldecTB\full_adder_behavioral_vhdl_TB.vhd" 
asim +access +r TESTBENCH_FOR_full_adder_behavioral_vhdl 
wave 
wave -noreg Cin
wave -noreg X1
wave -noreg X2
wave -noreg S
wave -noreg Cout
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\AldecTB\full_adder_behavioral_vhdl_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_full_adder_behavioral_vhdl 
