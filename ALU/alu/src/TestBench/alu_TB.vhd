library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
	-- Add your library and packages declaration here ...

entity alu_tb is
	-- Generic declarations of the tested unit
		generic(
		S : NATURAL := 1 );
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
		generic(
		S : NATURAL := 1 );
	port(				   
		Choose : in STD_LOGIC_VECTOR(3 downto 0);
		Output : out STD_LOGIC_VECTOR(7 downto 0);
		A : in STD_LOGIC_VECTOR(7 downto 0);
		B : in STD_LOGIC_VECTOR(7 downto 0);
		Cin : in STD_LOGIC;
		Cout : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity	 
	signal Output : STD_LOGIC_VECTOR(7 downto 0);	
	signal Choose : STD_LOGIC_VECTOR(3 downto 0);
	signal A : STD_LOGIC_VECTOR(7 downto 0);
	signal B : STD_LOGIC_VECTOR(7 downto 0);
	signal Cin : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Cout : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		generic map (
			S => S
		)

		port map (
			Choose => Choose,
			Output => Output,
			A => A,
			B => B,
			Cin => Cin,
			Cout => Cout
		);	 

	-- Add your stimulus here ...
	
	process
	   begin  
      	A <= "00000001";
  		B <= "00000100"; 
		Cin <= '1';
  		Choose <= "0000";
  		wait for 100 ns;
      	A <= "00001001";
  		B <= "00100001";  
		Choose <= "0001";
		Cin <= '0';
      	wait for 100 ns;
		A <= "00001101";
  		B <= "10100011";  
		Choose <= "0010";
		Cin <= '1';
      	wait for 100 ns;
		A <= "00101101";
  		B <= "10110011";  
		Choose <= "0011";
		Cin <= '1';
      	wait for 100 ns; 
		A <= "00101101";
  		B <= "10110011";  
		Choose <= "1011";
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001101";
  		B <= "00101011";  
		Choose <= "0100";
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001101";
  		B <= "00101011";  
		Choose <= "1100";
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001111";
  		B <= "00101011";  
		Choose <= "0101";	  
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001111";
  		B <= "00101011";  
		Choose <= "1101";	  
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001111";
  		B <= "00101011";  
		Choose <= "0110";	  
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001111";
  		B <= "00101011";  
		Choose <= "1110";	  
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001000";
  		B <= "00101011";  
		Choose <= "0111";	  
		Cin <= '1';
      	wait for 100 ns;
		A <= "00001000";
  		B <= "00101011";  
		Choose <= "1111";	  
		Cin <= '1';
      	wait for 100 ns;
   end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alu;

