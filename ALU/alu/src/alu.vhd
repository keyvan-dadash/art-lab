library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.ALL;

entity alu is
  generic ( 
     constant S: natural := 1
    );
  
    Port (	
	Choose  : in  STD_LOGIC_VECTOR(3 downto 0);
    Output   : out  STD_LOGIC_VECTOR(7 downto 0);
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);
    Cin	     : in  std_logic;
    Cout : out std_logic
    );
end alu; 
architecture Behavioral of alu is

signal tmp: std_logic_vector (8 downto 0);
signal Calculate : std_logic_vector (7 downto 0);

begin
   process(A,B,Choose,Calculate,Cin)
 begin
  case(Choose) is
  when "0000" =>				 
   Calculate <= A and B;		
  when "1000" =>
   Calculate <= A and B;
  when "0001" =>
   Calculate <= A or B; 
  when "1001" =>
   Calculate <= A or B;
  when "1010" =>
   Calculate <= A xor B;
  when "0010" =>
   Calculate <= A xor B;
  when "0011" =>
   Calculate <= A;
  when "1011" =>
   Calculate <= not A;
  when "0100" =>
   Calculate <= A + B + ( "0000000" & Cin); 
  when "1100" =>
   Calculate <= A - B + ( "0000000" & Cin);
  when "0101" =>
   Calculate <= std_logic_vector(unsigned(A) ror S);
  when "1101" =>
   Calculate <= std_logic_vector(unsigned(A) rol S);
  when "0110" =>
   Calculate <= std_logic_vector(unsigned(A) srl S); 
  when "1110" =>
   Calculate <= std_logic_vector(unsigned(A) sll S);
  when "0111" =>
   Calculate <= std_logic_vector(signed(A) srl S);
  when "1111" =>
   Calculate <= std_logic_vector(signed(A) sll S);
  when others =>
   Calculate <= A;
  end case;
 end process;
 Output <= Calculate;
 tmp <= ('0' & A) + ('0' & B ) + ( "00000000" & Cin);
 Cout <= tmp(8);
end Behavioral;
