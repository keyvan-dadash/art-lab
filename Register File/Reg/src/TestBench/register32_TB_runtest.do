SetActiveLib -work
comp -include "$dsn\src\register32.vhd" 
comp -include "$dsn\src\TestBench\register32_TB.vhd" 
asim +access +r TESTBENCH_FOR_register32 
wave 
wave -noreg data
wave -noreg readReg1
wave -noreg readReg2
wave -noreg writeReg
wave -noreg RegWrite
wave -noreg clr
wave -noreg clk
wave -noreg read1
wave -noreg read2
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\register32_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_register32 
