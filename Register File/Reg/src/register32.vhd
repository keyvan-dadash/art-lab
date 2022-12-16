library IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register32 IS PORT(
    data   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    readReg1  : IN STD_LOGIC_VECTOR(4 Downto 0);	  
	readReg2  : IN STD_LOGIC_VECTOR(4 Downto 0);
	writeReg  : IN STD_LOGIC_VECTOR(4 Downto 0);
	RegWrite : IN STd_logic;
    clr : IN STD_LOGIC;
    clk : IN STD_LOGIC;
    read1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	read2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END register32;

architecture Behavioral OF register32 IS
type Arr is array(31 downto 0) of std_logic_vector(31 downto 0);
signal cell : Arr;

BEGIN
    process(clk, clr)
    begin	   
		if (clk'event and clk='1') then	
			if clr = '1' then 
				FOR i IN 0 to 31 LOOP
					cell(i) <= (others => '0');
				end Loop;
	        elsif clr = '0' then
	            if RegWrite = '1' then
	                cell(to_integer(UNSIGNED(writeReg))) <= data;
	            end if;
	        end if;
		elsif (clk'event and clk='0') then
			read1 <=  cell(to_integer(UNSIGNED(readReg1)));
			read2 <=  cell(to_integer(UNSIGNED(readReg2)));
		end if;
    end process;
END Behavioral;
