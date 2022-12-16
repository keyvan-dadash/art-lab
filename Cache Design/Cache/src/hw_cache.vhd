library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HW_CACHE is
  Port ( address : in STD_LOGIC_VECTOR(31 downto 0);
          dn : in STD_LOGIC_VECTOR(255 downto 0);
          read : in STD_LOGIC;
          clk : in  STD_LOGIC;
          hit: out  STD_LOGIC;
          do : out  STD_LOGIC_VECTOR(31 downto 0));
end HW_CACHE;

architecture Behavioral of HW_CACHE is

type ex is array (127 downto 0) of std_logic_vector(279 downto 0);
signal cache : ex := (others => (others => '0'));
signal buffer_reg : STD_logic_vector(279 downto 0);
signal output : std_logic_vector(31 downto 0);

begin
  process(address, clk, cache)
  variable offset, local_index: integer;
  variable first_hit, second_hit: std_logic;
  variable data : std_logic_vector(279 downto 0);
  begin  
    if(rising_edge(clk)) then
      local_index := CONV_INTEGER(address(8 downto 3));
      offset := CONV_INTEGER(address(2 downto 0));
      if(read = '0') then
        data(0) := '1';
        data(23 downto 1) := address(31 downto 9);
        data(279 downto 24) := dn;
        cache(local_index) <= data;
        do <= data(32*(offset+1)+24 downto 32*offset+24);
        hit <= '1';
      end if;
      if(read = '1')  then
        data := cache(local_index);
        if(address(31 downto 9) = data(23 downto 1)) then
          first_hit := '1';
        else 
          first_hit := '0';
        end if;
        output <= data(32*(offset+1)+31 downto 32*offset+32);
        
        
        data := cache(local_index+64);
        if(address(31 downto 9) = data(23 downto 1)) then
          second_hit := '1';
        else 
          second_hit := '0';
        end if;
        output <= data(32*(offset+1)+31 downto 32*offset+32);
      end if;
    end if;
    if(first_hit = '1') then
      hit <= '1';
    end if;
    if(second_hit = '1')then
      hit <= '1';
    end if;
  end process;
  do <= output;
end Behavioral;