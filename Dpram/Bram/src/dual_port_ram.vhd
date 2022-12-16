library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dual_port_ram is
port(   clk: in std_logic;
		we : in std_logic; 
		oe : in std_logic;
        oe1 : in std_logic;
        addr : in std_logic_vector(9 downto 0);
        addr1 : in std_logic_vector(9 downto 0);
		di : in std_logic_vector(31 downto 0);
        dout : out std_logic_vector(31 downto 0);
        dout1 : out std_logic_vector(31 downto 0)
    );
end dual_port_ram;

architecture Behavioral of dual_port_ram is

type ram_type is array(0 to 1023) of std_logic_vector(31 downto 0);
signal ram : ram_type := (others => (others => '0'));

begin

process(clk)
begin
    if(rising_edge(clk)) then
        if(oe = '1') then
            if(we = '1') then
                ram(conv_integer(addr)) <= di;
            end if;
        end if;
    end if;
end process;

dout <= ram(conv_integer(addr)) when (oe = '1') else
            (others => 'Z');
dout1 <= ram(conv_integer(addr1)) when (oe1 = '1') else
            (others => 'Z');
            
end Behavioral;