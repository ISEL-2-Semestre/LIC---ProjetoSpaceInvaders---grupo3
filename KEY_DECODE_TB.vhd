LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KEY_DECODE_TB is
end KEY_DECODE_TB;

architecture arc_KEY_DECODE_TB of KEY_DECODE_TB is

Component KEY_DECODE
port( CLK, RESET, Kack : in std_logic;
		LIN : in std_logic_vector(3 downto 0);
		COL : out std_logic_vector (2 downto 0);
		K : out std_logic_vector(3 downto 0);
		Kval : out std_logic);
end component;

signal CLK_TB : std_logic := '0';
signal RESET_TB, Kack_TB, Kval_TB : std_logic;
signal LIN_TB, K_TB : std_logic_vector(3 downto 0);
signal COL_TB : std_logic_vector(2 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

    CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
	 
	 UUT: KEY_DECODE port map(	CLK => CLK_TB,
										RESET => RESET_TB,
										Kack => Kack_TB,
										LIN => LIN_TB,
										K => K_TB,
										Kval => Kval_TB
										);

stimulus : process
begin
	
	Kack_TB <= '0';
	RESET_TB <= '1';
	LIN_TB <= "1111";
	
	wait for CLK_PERIOD*2;
	
	RESET_TB <= '0';
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "1011";
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "1111";
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "1011";

	wait for CLK_PERIOD;
	
	Kack_TB <= '1';
	
	wait for CLK_PERIOD;
	
	LIN_TB <= "1111";
	
	wait for CLK_PERIOD;

	Kack_TB <= '0';
	
	wait for CLK_PERIOD*5;
	
	LIN_TB <= "1110";
	
	wait for CLK_PERIOD;
	
	LIN_TB <= "1111";
	
	wait for CLK_PERIOD;
	
end process;
	
end architecture;