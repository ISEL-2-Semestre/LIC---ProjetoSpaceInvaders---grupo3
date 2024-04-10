LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity KEY_CONTROL_tb is
end KEY_CONTROL_tb;

Architecture arc_KEY_CONTROL_tb of KEY_CONTROL_tb is

Component KEY_CONTROL is
Port(	Kack, Kpress, CLK, RESET : in std_logic;
		Kscan, Kval : out std_logic
		);
end component;

-- UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal Kack_tb : std_logic;
signal Kpress_tb : std_logic;
signal CLK_tb : std_logic;
signal RESET_tb : std_logic;
signal Kscan_tb : std_logic;
signal Kval_tb : std_logic;

begin

-- Unit Under Test
UUT: KEY_CONTROL
		port map(Kack => Kack_tb,
					Kpress => Kpress_tb,
					CLK => CLK_tb,
					RESET => RESET_tb,
					Kscan => Kscan_tb,
					Kval => Kval_tb);

clk_gen : process
begin
		CLK_tb <= '1';
		wait for MCLK_HALF_PERIOD;
		CLK_tb <= '0';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process 
begin
	-- reset
	RESET_tb <= '1';
	Kack_tb <= '0';
	Kpress_tb <= '0';
	
	wait for MCLK_PERIOD;
	
	RESET_tb <= '0';
	
	wait for MCLK_PERIOD;

	Kpress_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	Kpress_tb <= '0';
	
	wait for MCLK_PERIOD;
	
	Kack_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	Kpress_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	Kack_tb <= '0';

	wait;
end process;

end architecture;