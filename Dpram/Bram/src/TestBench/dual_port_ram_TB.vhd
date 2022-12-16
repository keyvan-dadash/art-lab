library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_ARITH.ALL;

	-- Add your library and packages declaration here ...

entity dual_port_ram_tb is
end dual_port_ram_tb;

architecture TB_ARCHITECTURE of dual_port_ram_tb is
	-- Component declaration of the tested unit
	component dual_port_ram
	port(
		clk : in STD_LOGIC;
		we : in STD_LOGIC;
		di : in STD_LOGIC_VECTOR(31 downto 0);
		addr : in STD_LOGIC_VECTOR(9 downto 0);
		addr1 : in STD_LOGIC_VECTOR(9 downto 0);
		oe : in STD_LOGIC;
		oe1 : in STD_LOGIC;
		dout : out STD_LOGIC_VECTOR(31 downto 0);
		dout1 : out STD_LOGIC_VECTOR(31 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal we : STD_LOGIC;
	signal di : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal addr : STD_LOGIC_VECTOR(9 downto 0):= (others => '0');
	signal addr1 : STD_LOGIC_VECTOR(9 downto 0):= (others => '0');
	signal oe : STD_LOGIC;
	signal oe1 : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal dout : STD_LOGIC_VECTOR(31 downto 0);
	signal dout1 : STD_LOGIC_VECTOR(31 downto 0);	
	
	constant clk_period : time := 10 ns;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : dual_port_ram
		port map (
			clk => clk,
			we => we,
			di => di,
			addr => addr,
			addr1 => addr1,
			oe => oe,
			oe1 => oe1,
			dout => dout,
			dout1 => dout1
		);	 
		
	clk_process :process
	begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
	end process;

	-- Add your stimulus here ... 
	stimulus_proc: process
	begin     
        oe <= '0';
        we <= '1';
        di <= X"FFFFFFFF";
        addr <= "0000000011";  
        wait for 20 ns;

        oe <= '1';   
        for i in 1 to 1024 loop
             di <= conv_std_logic_vector(i,32);
             addr <= conv_std_logic_vector(i-1,10);
             wait for 10 ns;
        end loop;
        we <= '0';
        oe <= '0';   

        oe1 <= '1';   
        for i in 1 to 1024 loop
            addr <= conv_std_logic_vector(i-1,10);
            wait for 10 ns;
        end loop;
        oe1 <= '0';   
      wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_dual_port_ram of dual_port_ram_tb is
	for TB_ARCHITECTURE
		for UUT : dual_port_ram
			use entity work.dual_port_ram(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_dual_port_ram;

