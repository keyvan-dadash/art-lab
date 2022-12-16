library ieee;
use ieee.MATH_REAL.all;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity cache_tb is
end cache_tb;

architecture TB_ARCHITECTURE of cache_tb is
	-- Component declaration of the tested unit
	component cache
	port(
		clk : in STD_LOGIC;
		write0 : in STD_LOGIC;
		write1 : in STD_LOGIC;
		write2 : in STD_LOGIC;
		write3 : in STD_LOGIC;
		memwrite : in STD_LOGIC;
		address : in STD_LOGIC_VECTOR(31 downto 0);
		dataToWrite : in STD_LOGIC_VECTOR(31 downto 0);
		memoryDataAtIndex0 : in STD_LOGIC_VECTOR(31 downto 0);
		memoryDataAtIndex1 : in STD_LOGIC_VECTOR(31 downto 0);
		memoryDataAtIndex2 : in STD_LOGIC_VECTOR(31 downto 0);
		memoryDataAtIndex3 : in STD_LOGIC_VECTOR(31 downto 0);
		Output : out STD_LOGIC_VECTOR(31 downto 0);
		hitForIndex0 : out STD_LOGIC;
		hitForIndex1 : out STD_LOGIC;
		hitForIndex2 : out STD_LOGIC;
		hitForIndex3 : out STD_LOGIC;
		miss : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal write0 : STD_LOGIC;
	signal write1 : STD_LOGIC;
	signal write2 : STD_LOGIC;
	signal write3 : STD_LOGIC;
	signal memwrite : STD_LOGIC;
	signal address : STD_LOGIC_VECTOR(31 downto 0);
	signal dataToWrite : STD_LOGIC_VECTOR(31 downto 0);
	signal memoryDataAtIndex0 : STD_LOGIC_VECTOR(31 downto 0);
	signal memoryDataAtIndex1 : STD_LOGIC_VECTOR(31 downto 0);
	signal memoryDataAtIndex2 : STD_LOGIC_VECTOR(31 downto 0);
	signal memoryDataAtIndex3 : STD_LOGIC_VECTOR(31 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Output : STD_LOGIC_VECTOR(31 downto 0);
	signal hitForIndex0 : STD_LOGIC;
	signal hitForIndex1 : STD_LOGIC;
	signal hitForIndex2 : STD_LOGIC;
	signal hitForIndex3 : STD_LOGIC;
	signal miss : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cache
		port map (
			clk => clk,
			write0 => write0,
			write1 => write1,
			write2 => write2,
			write3 => write3,
			memwrite => memwrite,
			address => address,
			dataToWrite => dataToWrite,
			memoryDataAtIndex0 => memoryDataAtIndex0,
			memoryDataAtIndex1 => memoryDataAtIndex1,
			memoryDataAtIndex2 => memoryDataAtIndex2,
			memoryDataAtIndex3 => memoryDataAtIndex3,
			Output => Output,
			hitForIndex0 => hitForIndex0,
			hitForIndex1 => hitForIndex1,
			hitForIndex2 => hitForIndex2,
			hitForIndex3 => hitForIndex3,
			miss => miss
		);

		  process
			begin
			 write0  <= '1'  ;
			wait for 100 ns ;
			 write0  <= '0'  ;
			wait for 150 ns ;
			 write0  <= '1'  ;
			wait for 200 ns ;
			 write0  <= '0'  ;
			wait for 250 ns ;
			 write0  <= '1'  ;
			wait for 300 ns ;
			wait;
		 end process;	 
		 process
			begin
			 memwrite  <= '1'  ;
			wait for 100 ns ;
			 memwrite  <= '0'  ;
			wait for 150 ns ;
			 memwrite  <= '0'  ;
			wait for 200 ns ;  
			 memwrite  <= '1'  ;
			wait for 250 ns ;
			 memwrite  <= '1'  ;
			wait for 300 ns ;
			wait;
		 end process;
		 process
			begin
			 memoryDataAtIndex0  <= "00000001000000000001000000000000"  ;
			wait for 100 ns ;
			 memoryDataAtIndex0  <= "00000000000000000000000000000000"  ;
			wait for 150 ns ;
			 memoryDataAtIndex0  <= "00000100000000010000000000100000"  ;
			wait for 200 ns ;	  
			 memoryDataAtIndex0  <= "00000100000000010000010000100000"  ;
			wait for 250 ns ;
			 memoryDataAtIndex0  <= "00000100000000010001000000100000"  ;
			wait for 300 ns ;
			wait;
		 end process;
		 process
			begin
			 memoryDataAtIndex2  <= "00000100000000010000000000100000"  ;
			wait for 100 ns ;
			 memoryDataAtIndex2  <= "00100000000100000100000000010010"  ;
			wait for 150 ns ;
			 memoryDataAtIndex2  <= "00000001000000000001000000000000"  ;
			wait for 200 ns ; 
			 memoryDataAtIndex2  <= "00000001000000100001000000000000"  ;
			wait for 250 ns ;
			 memoryDataAtIndex2  <= "00000001000010000001000000000000"  ;
			wait for 300 ns ;
		-- dumped values till 10 us
			wait;
		 end process;

		 
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cache of cache_tb is
	for TB_ARCHITECTURE
		for UUT : cache
			use entity work.cache(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_cache;

