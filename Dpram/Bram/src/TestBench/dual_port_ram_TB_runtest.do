SetActiveLib -work
comp -include "$dsn\src\dual_port_ram.vhd" 
comp -include "$dsn\src\TestBench\dual_port_ram_TB.vhd" 
asim +access +r TESTBENCH_FOR_dual_port_ram 
wave 
wave -noreg clk
wave -noreg wr_en
wave -noreg data_in
wave -noreg addr_in_0
wave -noreg addr_in_1
wave -noreg port_en_0
wave -noreg port_en_1
wave -noreg data_out_0
wave -noreg data_out_1
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\dual_port_ram_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_dual_port_ram 
