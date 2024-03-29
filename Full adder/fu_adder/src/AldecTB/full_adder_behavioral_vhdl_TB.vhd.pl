#//********************************************************************
# This file is generated by Aldec TestBench Wizard!!!
# If your delete this file your never see your vhdl code! :-)
#	filename: 	AldecTbGenerator.pl
#	file base:	Aldec
#	file ext:	pl
#	author:		Michal Pacula, Alexandr Gaysin
#
#	purpose:	PERL RULEZzz!!!	
#*********************************************************************//
use Aldec::stimulus_declaration; 

format Aldec_TB = 
@*
 library_declaration();
	-- Add your library and packages declaration here ...

entity full_adder_behavioral_vhdl_tb is
end full_adder_behavioral_vhdl_tb;

architecture TB_ARCHITECTURE of full_adder_behavioral_vhdl_tb is
	-- Component declaration of the tested unit
	component full_adder_behavioral_vhdl
	port(
		Cin : in STD_LOGIC;
		X1 : in STD_LOGIC_VECTOR(7 downto 0);
		X2 : in STD_LOGIC_VECTOR(7 downto 0);
		S : out STD_LOGIC_VECTOR(7 downto 0);
		Cout : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal Cin : STD_LOGIC;
	signal X1 : STD_LOGIC_VECTOR(7 downto 0);
	signal X2 : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal S : STD_LOGIC_VECTOR(7 downto 0);
	signal Cout : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : full_adder_behavioral_vhdl
		port map (
			Cin => Cin,
			X1 => X1,
			X2 => X2,
			S => S,
			Cout => Cout
		);

	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_full_adder_behavioral_vhdl of full_adder_behavioral_vhdl_tb is
	for TB_ARCHITECTURE
		for UUT : full_adder_behavioral_vhdl
			use entity work.full_adder_behavioral_vhdl(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_full_adder_behavioral_vhdl;

. 

	#my $HDL_FileNamePath	= shift;
	my $HDL_FNP = ">" .'d:\fucking uni\Fucking_CA_Lab\sh\full_adder\fu_adder\src\AldecTB\full_adder_behavioral_vhdl_TB.vhd';
	print $HDL_FNP;
	open( Aldec_TB,  $HDL_FNP) or die "Cannot create .hdl file";
	write Aldec_TB;
	close FUNCFL;
