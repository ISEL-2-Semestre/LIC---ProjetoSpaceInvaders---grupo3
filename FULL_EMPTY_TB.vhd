LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity FULL_EMPTY_TB is
end FULL_EMPTY_TB;

Architecture arc_FULL_EMPTY_TB of FULL_EMPTY_TB is

Component FULL_EMPTY is
Port( CD, CU, CLK, RESET : in std_logic;
		empty, full : out std_logic
        );
End Component;


constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal CU_TB : std_logic;
signal CD_TB : std_logic;
signal CLK_TB : std_logic;
signal RESET_TB : std_logic;
signal empty_TB : std_logic;
signal full_TB : std_logic;

begin

UUT: FULL_EMPTY 
		port map(CD => CD_TB,
					CU => CU_TB,
					CLK => CLK_TB,
					RESET => RESET_TB,
					empty => empty_TB,
					full => full_TB);

clk_gen : process
begin
		CLK_TB <= '1';
		wait for MCLK_HALF_PERIOD;
		CLK_TB <= '0';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process 
begin

	CU_TB <= '0';
	CD_TB <= '0';
	RESET_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';
	
	wait for MCLK_PERIOD*2;
	
	CU_TB <= '1';
	
	wait for MCLK_PERIOD*4;
	
	CU_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	CD_TB <= '1';
	
	wait for MCLK_PERIOD*3;
	
	CD_TB <= '0';
	CU_TB <= '1';
	
	wait for MCLK_PERIOD*6;
	
	CD_TB <= '1';
	CU_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	CU_TB <= '1';
	CD_TB <= '0';
	
	wait;
	
	end process;
	
	end architecture;