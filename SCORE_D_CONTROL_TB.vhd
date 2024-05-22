LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SCORE_D_CONTROL_TB is
end SCORE_D_CONTROL_TB;

Architecture arc_SCORE_D_CONTROL_TB of SCORE_D_CONTROL_TB is

Component SCORE_D_CONTROL is
Port(	Dval	: in std_logic;
		CLK	: in std_logic;
		RESET : in std_logic;
		Wrd	: out std_logic;
		done 	: out std_logic);
end component;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal Dval_TB : std_logic;
signal CLK_TB : std_logic;
signal RESET_TB : std_logic;
signal Wrd_TB : std_logic;
signal done_TB : std_logic;

begin

UUT: SCORE_D_CONTROL
		port map(Dval => Dval_TB,
					CLK => CLK_TB,
					RESET => RESET_TB,
					Wrd => Wrd_TB,
					done => done_TB
					);

clk_gen : process
begin
		CLK_TB <= '1';
		wait for MCLK_HALF_PERIOD;
		CLK_TB <= '0';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process 
begin

	RESET_TB <= '1';
	Dval_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';

	wait for MCLK_PERIOD;

	Dval_TB <= '1';
	
	wait for MCLK_PERIOD*3;

	Dval_TB <= '0';	
	
	wait for MCLK_PERIOD;
	
	Dval_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	wait;
end process;

end architecture;