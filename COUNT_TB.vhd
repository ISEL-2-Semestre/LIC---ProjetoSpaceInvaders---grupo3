LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity COUNT_TB is
end COUNT_TB;

architecture arc_COUNT_TB of COUNT_TB is

component COUNTER_UP
Port( dataIn : in std_logic_vector(3 downto 0);
		RESET : in std_logic;
		PL : in std_logic;
		CE : in std_logic;
		CLK : in std_logic;
		Q : out std_logic_vector(3 downto 0));
End component;

signal RESET_TB, CLK_TB : std_logic := '0';
signal dataIn_TB : std_logic_vector(3 downto 0);
signal CE_TB : std_logic;
signal PL_TB : std_logic;
signal Q_TB : std_logic_vector(3 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

	CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
	
	UUT: COUNTER_UP port map(	dataIn => dataIn_TB,
								RESET => RESET_TB,
								PL => PL_TB,
								CE => CE_TB,
								CLK => CLK_TB,
								Q => Q_TB
	);
	
stimulus: process 
begin

	RESET_TB <= '1';
	PL_TB <= '1';
	dataIn_TB <= "0000";
	CE_TB <= '0';
	
	wait for CLK_PERIOD*2;
	
	RESET_TB <= '0';
	
	wait for CLK_PERIOD;
	

	PL_TB <= '0';

	
	wait for CLK_PERIOD;
	
	CE_TB <= '1';
	
	wait for CLK_PERIOD*20;
	
	wait;
	
end process;

end architecture;