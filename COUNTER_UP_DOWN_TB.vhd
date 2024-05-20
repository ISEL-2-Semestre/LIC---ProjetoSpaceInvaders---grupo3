LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity COUNTER_UP_DOWN_TB is
end COUNTER_UP_DOWN_TB;

architecture arc_COUNTER_UP_DOWN_TB of COUNTER_UP_DOWN_TB is

component COUNTER_UP_DOWN
Port( CU, CD, RESET, CLK : in std_logic;
		Q : out std_logic_vector(3 downto 0));
End component;

signal RESET_TB, CLK_TB : std_logic := '0';
signal CU_TB : std_logic;
signal CD_TB : std_logic;
signal Q_TB : std_logic_vector(3 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

	CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
	
	UUT: COUNTER_UP_DOWN port map(	CU => CU_TB,
								CD => CD_TB,
								RESET => RESET_TB,
								CLK => CLK_TB,
								Q => Q_TB
	);
	
stimulus: process 
begin

	RESET_TB <= '1';
	CD_TB <= '0';
	CU_TB <= '0';
	
	wait for CLK_PERIOD*2;
	
	RESET_TB <= '0';
	
	wait for CLK_PERIOD;

	CU_TB <= '1';
	
	wait for CLK_PERIOD*7;
	
	CU_TB <= '0';
	CD_TB <= '1';
	
	wait for CLK_PERIOD*7;
	
	wait;
	
end process;

end architecture;