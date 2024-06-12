LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity SPACE_INVADERS_TB is
end SPACE_INVADERS_TB;

architecture arc_SPACE_INVADERS_TB of SPACE_INVADERS_TB is

Component SPACE_INVADERS is
Port( RESET, CLK, ACK, nSCsel, nLCDsel, SDX : in std_logic;
		LIN : in std_logic_vector(3 downto 0);
		Wrd, Wrl, Dval : out std_logic;
      COL : out std_logic_vector(2 downto 0);
		Q : out std_logic_vector(3 downto 0);
		DoutSSC : out std_logic_vector(6 downto 0);
		DoutLCD : out std_logic_vector(8 downto 0));
end component;

signal CLK_TB : std_logic := '0';
signal RESET_TB, Wrd_TB, ACK_TB, Dval_TB, Wrl_TB, nSCsel_TB, nLCDsel_TB, SDX_TB : std_logic;
signal COL_TB : std_logic_vector(2 downto 0);
signal Q_TB, LIN_TB : std_logic_vector(3 downto 0);
signal DoutSSC_TB : std_logic_vector(6 downto 0);
signal DoutLCD_TB : std_logic_vector(8 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

    CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
	 
	 UUT: SPACE_INVADERS port map(	CLK => CLK_TB,
										RESET => RESET_TB,
										ACK => ACK_TB,
										nSCsel => nSCsel_TB,
										nLCDsel => nLCDsel_TB,
										SDX => SDX_TB,
										LIN => LIN_TB,
										Wrl => Wrl_TB,
										Wrd => Wrd_TB,
										Dval => Dval_TB,
										Q => Q_TB,
										COL => COL_TB,
										DoutSSC => DoutSSC_TB,
										DoutLCD => DoutLCD_TB
										);

stimulus : process
begin

	RESET_TB <= '1';
	ACK_TB <= '0';
	LIN_TB <= "1111";
	nSCsel_TB <= '0';
	nLCDsel_TB <= '0';
	SDX_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	LIN_TB <= "1011";
	nSCsel_TB <= '1';
	nLCDsel_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	SDX_TB <= '1';	
	
	wait for MCLK_PERIOD*3;
	
	SDX_TB <= '0';	
	LIN_TB <= "1011";

	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '1';
	
	wait for MCLK_PERIOD*5;
	
	ACK_TB <= '1';
	LIN_TB <= "1111";

	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '0';	
	ACK_TB <= '0';

	wait for MCLK_PERIOD*5;
	
	LIN_TB <= "1010";
	
	wait for MCLK_PERIOD*2;
	
	SDX_TB <= '1';
	ACK_TB <= '1';
	
	wait;
end process;
	
end architecture;