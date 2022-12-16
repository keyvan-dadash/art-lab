library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
-- Add your library and packages declaration here ...

entity full_adder_behavioral_vhdl_tb is
end full_adder_behavioral_vhdl_tb;

architecture TB_ARCHITECTURE of full_adder_behavioral_vhdl_tb is
	-- Component declaration of the tested unit
	component full_adder_behavioral_vhdl
		port(
			Cin : in STD_LOGIC;
			X1 : in STD_LOGIC_VECTOR(7 downto 0);
			X2 : in STD_LOGIC_VECTOR(7 downto 0);
			S : out STD_LOGIC_VECTOR(7 downto 0);
			Cout : out STD_LOGIC );
	end component;
	
	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Cin : STD_LOGIC;
	signal X1 : STD_LOGIC_VECTOR(7 downto 0);
	signal X2 : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal S : STD_LOGIC_VECTOR(7 downto 0);
	signal Cout : STD_LOGIC;
	
	-- Add your code here ...
	
begin
	
	-- Unit Under Test port map
	UUT : full_adder_behavioral_vhdl
	port map (
		Cin => Cin,
		X1 => X1,
		X2 => X2,
		S => S,
		Cout => Cout
		);
	
	process
	begin
		X1 <= "10000000";
		X2 <= "10000001";
		Cin <= '1';
		wait for 50 ns; 
		X1 <= "00000101";
		X2 <= "00000010";
		Cin <= '0';
		wait for 50 ns; 
		X1 <= "00000001";
		X2 <= "00000100";
		Cin <= '1';
		wait for 50 ns;
		X1 <= "00000010";
		X2 <= "00000101";
		Cin <= '0';
		wait for 50 ns;
		X1 <= "00001000";
		X2 <= "00000001";
		Cin <= '1';
		wait for 50 ns;   
		X1 <= "00000010";
		X2 <= "00000100";
		Cin <= '0';
		wait for 50 ns;
		X1 <= "00000000";
		X2 <= "00000000";
		Cin <= '1';
		wait for 50 ns;
		X1 <= "00001000";
		X2 <= "00000010";
		Cin <= '0';
		wait for 50 ns;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_full_adder_behavioral_vhdl of full_adder_behavioral_vhdl_tb is
	for TB_ARCHITECTURE
		for UUT : full_adder_behavioral_vhdl
			use entity work.full_adder_behavioral_vhdl(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_full_adder_behavioral_vhdl;

