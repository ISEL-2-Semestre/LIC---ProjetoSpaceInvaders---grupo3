LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KEYBOARD_READER_TB is
end KEYBOARD_READER_TB;

architecture arc_KEYBOARD_READER_TB of KEYBOARD_READER_TB is

Component KEYBOARD_READER
port( LIN 	: in std_logic_vector(3 downto 0);
      ACK 	: in std_logic;
      CLK 	: in std_logic;
      RESET : in std_logic;
      COL 	: out std_logic_vector(2 downto 0);
      Q 		: out std_logic_vector(3 downto 0);
		Dval 	: out std_logic);
end component;

signal CLK_TB : std_logic := '0';
signal RESET_TB, ACK_TB, Dval_TB : std_logic;
signal LIN_TB, Q_TB : std_logic_vector(3 downto 0);
signal COL_TB : std_logic_vector(2 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

    CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
	 
	 UUT: KEYBOARD_READER port map(	CLK => CLK_TB,
										RESET => RESET_TB,
										ACK => ACK_TB,
										LIN => LIN_TB,
										COL => COL_TB,
										Q => Q_TB,
										Dval => Dval_TB
										);

stimulus : process
begin
	
	ACK_TB <= '0';
	RESET_TB <= '1';
	LIN_TB <= "1111";
	
	wait for CLK_PERIOD*2;
	
	RESET_TB <= '0';
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "1011";
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "1111";
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "0111";

	wait for CLK_PERIOD;
	
	ACK_TB <= '1';
	
	wait for CLK_PERIOD;
	
	LIN_TB <= "1111";
	
	wait for CLK_PERIOD;

	ACK_TB <= '0';
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "1010";
	
	wait for CLK_PERIOD;
	
	LIN_TB <= "1100";
	
	wait for CLK_PERIOD;
	
end process;
	
end architecture;