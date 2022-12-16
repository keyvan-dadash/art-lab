library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity cache is 
	port (
	clk, write0 , write1, write2, write3, memwrite : in std_logic; --clock and write
	address: in std_logic_vector (31 downto 0); --desire address
	dataToWrite : in std_logic_vector (31 downto 0); --data to write
	memoryDataAtIndex0 : in std_logic_vector (31 downto 0);
	memoryDataAtIndex1 : in std_logic_vector (31 downto 0);
	memoryDataAtIndex2 : in std_logic_vector (31 downto 0);
	memoryDataAtIndex3 : in std_logic_vector (31 downto 0);
	Output : out std_logic_vector (31 downto 0);
	hitForIndex0, hitForIndex1, hitForIndex2, hitForIndex3, miss : out std_logic -- hit index
	);
end entity;

architecture behavioral of cache is
	type tagForIndex is array (0 to 63) of std_logic_vector (24 downto 0);
	signal tagForIndex0 : tagForIndex := (others => (others => '0')); -- define tags
	signal tagForIndex1 : tagForIndex := (others => (others => '0'));
	signal tagForIndex2 : tagForIndex := (others => (others => '0'));
	signal tagForIndex3 : tagForIndex := (others => (others => '0'));

	type DataArray is array (0 to 63,0 to 3) of std_logic_vector (31 downto 0);
	signal data0 : DataArray := (others => (others => (others => 'Z')));
	signal data1 : DataArray := (others => (others => (others => 'Z')));
	signal data2 : DataArray := (others => (others => (others => 'Z')));
	signal data3 : DataArray := (others => (others => (others => 'Z')));  
	
	signal dataOut0 , dataOut1  , dataOut2 , dataOut3: std_logic_vector(31 downto 0);
	signal tagOut0 , tagOut1 , tagOut2 , tagOut3: std_logic_vector(24 downto 0);
	
	signal BlockOffset : std_logic_vector(1 downto 0); 
	signal cacheAddressForRetrive : std_logic_vector(7 downto 2); 
	signal CachetagForIndex : std_logic_vector(31 downto 8);
	
	signal missedHit , genHit , inHitForIndex0 , inHitForIndex1 ,inHitForIndex2 ,inHitForIndex3 : std_logic;
	signal resetWhole , isRecent : std_logic;
	
	
begin		  
	Output <= dataOut0 when inHitForIndex0 = '1' else
			dataOut1 when inHitForIndex1 = '1' else
			dataOut2 when inHitForIndex2 = '1' else
			dataOut3 when inHitForIndex3 = '1' else
			(others => 'Z');
			
			
	BlockOffset <= address(1 downto 0);
	cacheAddressForRetrive <= address(7 downto 2);
	CachetagForIndex <= address(31 downto 8);

	
	hitForIndex0 <= inHitForIndex0;
	hitForIndex1 <= inHitForIndex1;
	hitForIndex2 <= inHitForIndex2;
	hitForIndex3 <= inHitForIndex3;
	miss <= missedHit;

	process (clk)
	begin		
		tagOut0 <= tagForIndex0(to_integer(unsigned(cacheAddressForRetrive)));
	tagOut1 <= tagForIndex1(to_integer(unsigned(cacheAddressForRetrive)));
	tagOut2 <= tagForIndex2(to_integer(unsigned(cacheAddressForRetrive)));
	tagOut3 <= tagForIndex3(to_integer(unsigned(cacheAddressForRetrive)));
		if rising_edge(clk) then
			if memwrite = '1' then
				if write0 = '1' then	 --first write
					data0(to_integer(unsigned(cacheAddressForRetrive)),0) <= memoryDataAtIndex0;
					data0(to_integer(unsigned(cacheAddressForRetrive)),1) <= memoryDataAtIndex1;
					data0(to_integer(unsigned(cacheAddressForRetrive)),2) <= memoryDataAtIndex2;
					data0(to_integer(unsigned(cacheAddressForRetrive)),3) <= memoryDataAtIndex3;
				elsif write1 = '1' then	   --second write
					data1(to_integer(unsigned(cacheAddressForRetrive)),0) <= memoryDataAtIndex0;
					data1(to_integer(unsigned(cacheAddressForRetrive)),1) <= memoryDataAtIndex1;
					data1(to_integer(unsigned(cacheAddressForRetrive)),2) <= memoryDataAtIndex2;
					data1(to_integer(unsigned(cacheAddressForRetrive)),3) <= memoryDataAtIndex3;
				elsif write2 = '1' then		  --third write
					data2(to_integer(unsigned(cacheAddressForRetrive)),0) <= memoryDataAtIndex0;
					data2(to_integer(unsigned(cacheAddressForRetrive)),1) <= memoryDataAtIndex1;
					data2(to_integer(unsigned(cacheAddressForRetrive)),2) <= memoryDataAtIndex2;
					data2(to_integer(unsigned(cacheAddressForRetrive)),3) <= memoryDataAtIndex3;
				else					 --fourth write
					data3(to_integer(unsigned(cacheAddressForRetrive)),0) <= memoryDataAtIndex0;
					data3(to_integer(unsigned(cacheAddressForRetrive)),1) <= memoryDataAtIndex1;
					data3(to_integer(unsigned(cacheAddressForRetrive)),2) <= memoryDataAtIndex2;
					data3(to_integer(unsigned(cacheAddressForRetrive)),3) <= memoryDataAtIndex3;
				end if;
			else
				if write0 = '1' then
					data0(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset))) <= dataToWrite;
				end if;
				if write1 = '1' then
					data1(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset))) <= dataToWrite;
				end if;
				if write2 = '1' then
					data2(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset))) <= dataToWrite;
				end if;
				if write3 = '1' then
					data3(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset))) <= dataToWrite;
				end if;
			end if;
		end if;
	end process;
	dataOut0 <= data0(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset)));
	dataOut1 <= data1(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset)));
	dataOut2 <= data2(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset)));
	dataOut3 <= data3(to_integer(unsigned(cacheAddressForRetrive)),to_integer(unsigned(BlockOffset)));
	
	process (clk)
	begin
		if rising_edge(clk) then
			if write0 = '1' then
				tagForIndex0(to_integer(unsigned(cacheAddressForRetrive))) <= "1" & CachetagForIndex;
			end if;

			if write1 = '1' then
				tagForIndex1(to_integer(unsigned(cacheAddressForRetrive))) <= "1" & CachetagForIndex;
			end if;
			
			if write2 = '1' then
				tagForIndex2(to_integer(unsigned(cacheAddressForRetrive))) <= "1" & CachetagForIndex;
			end if;

			if write3 = '1' then
				tagForIndex3(to_integer(unsigned(cacheAddressForRetrive))) <= "1" & CachetagForIndex;
			end if;	 
			
			if isRecent = '1' then	 
				tagForIndex0(to_integer(unsigned(cacheAddressForRetrive)))(0) <= '0';
				tagForIndex1(to_integer(unsigned(cacheAddressForRetrive)))(0) <= '0';
				tagForIndex2(to_integer(unsigned(cacheAddressForRetrive)))(0) <= '0';
				tagForIndex3(to_integer(unsigned(cacheAddressForRetrive)))(0) <= '0';
			end if;
			if resetWhole = '1' then  
				tagForIndex0<= (others => (others => '0'));
				tagForIndex1 <= (others => (others => '0'));
				tagForIndex2 <= (others => (others => '0'));
				tagForIndex3 <= (others => (others => '0'));
			end if;
		end if;
	end process;
	genHit <= '1' when '1' & CachetagForIndex = tagOut0 or '1' & CachetagForIndex = tagOut1 or '1' & CachetagForIndex = tagOut2 or '1' & CachetagForIndex = tagOut3 else '0';
	inHitForIndex0 <= '1' when tagOut0 = '1' & CachetagForIndex else '0';
	inHitForIndex1 <= '1' when tagOut1 = '1' & CachetagForIndex else '0';
	inHitForIndex2 <= '1' when tagOut2 = '1' & CachetagForIndex else '0';
	inHitForIndex3 <= '1' when tagOut3 = '1' & CachetagForIndex else '0';
	missedHit <= '1' when inHitForIndex0 = '0' and inHitForIndex1 = '0' and inHitForIndex2 = '0' and inHitForIndex3 = '0' else '0';
end architecture;