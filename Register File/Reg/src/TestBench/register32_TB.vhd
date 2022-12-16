library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity register32_tb is
end register32_tb;

architecture TB_ARCHITECTURE of register32_tb is
	-- Component declaration of the tested unit
	component register32
	port(
		data : in STD_LOGIC_VECTOR(31 downto 0);
		readReg1 : in STD_LOGIC_VECTOR(4 downto 0);
		readReg2 : in STD_LOGIC_VECTOR(4 downto 0);
		writeReg : in STD_LOGIC_VECTOR(4 downto 0);
		RegWrite : in STD_LOGIC;
		clr : in STD_LOGIC;
		clk : in STD_LOGIC;
		read1 : out STD_LOGIC_VECTOR(31 downto 0);
		read2 : out STD_LOGIC_VECTOR(31 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal data : STD_LOGIC_VECTOR(31 downto 0);
	signal readReg1 : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal readReg2 : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal writeReg : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal RegWrite : STD_LOGIC;
	signal clr : STD_LOGIC;
	signal clk : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal read1 : STD_LOGIC_VECTOR(31 downto 0);
	signal read2 : STD_LOGIC_VECTOR(31 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : register32
		port map (
			data => data,
			readReg1 => readReg1,
			readReg2 => readReg2,
			writeReg => writeReg,
			RegWrite => RegWrite,
			clr => clr,
			clk => clk,
			read1 => read1,
			read2 => read2
		);

	-- Add your stimulus here ...
	clk <= not clk after 10 ns;	
	clr <= '1','0' after 20 ns;
	process
	begin
		wait for 50 ns;
		data <= "00000000000000000000000000010010";
      	RegWrite <= '1';
  		writeReg <= "00001";
		wait for 20 ns;
		RegWrite <= '0';
  		wait for 100 ns;
		RegWrite <= '1';
      	data <= "00000000000000000000000000010111";
  		writeReg <= "00010";
		wait for 20 ns;
		RegWrite <= '0';
  		wait for 100 ns;
      	readReg1 <= "00010";
  		readReg2 <= "00001";
  		wait for 100 ns;
		readReg1 <= "00001";
  		readReg2 <= "00010";
		wait;
   end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_register32 of register32_tb is
	for TB_ARCHITECTURE
		for UUT : register32
			use entity work.register32(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_register32;

