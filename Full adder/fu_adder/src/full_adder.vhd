library ieee; 
use ieee.std_logic_1164.all;  
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Full_Adder_Behavioral_VHDL is  
	port(
		Cin : in std_logic;
		X1, X2: in std_logic_vector(7 downto 0);  
		S : out std_logic_vector(7 downto 0);
		Cout : out std_logic
		);  
end Full_Adder_Behavioral_VHDL;  
architecture Behavioral of Full_Adder_Behavioral_VHDL is   
	signal c : std_logic_vector(7 downto 0);	 
	signal temp : std_logic_vector(7 downto 0);
begin  
	process(X1,X2,Cin,c,temp)
	begin		  
		temp(0) <= X1(0) xor X2(0) xor Cin;
		c(0) <= (Cin and X1(0)) or (Cin and X2(0)) or (X1(0) and X2(0));	
		for i in 1 to 7 loop
			temp(i)  <= X1(i) xor X2(i) xor c(i-1);
			c(i)   <= (c(i-1) and X1(i)) or (c(i-1) and X2(i)) or (X1(i) and X2(i));
		end loop;
	end process; 
	Cout <= c(7); 
	S <= temp;
end Behavioral;