library ieee;
use ieee.std_logic_1164.all;

entity PARITY_CHECK_TB is 
end PARITY_CHECK_TB;

architecture arc_PARITY_CHECK_TB of PARITY_CHECK_TB is

component PARITY_CHECK
port(
    data, clk, init, Reset: in std_logic;
    err: out std_logic
    );
end component;

signal data_TB : std_logic;
signal CLK_TB : std_logic;
signal init_TB : std_logic;
signal err_TB : std_logic;
signal Reset_TB : std_logic;


constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin
    
    UUT: PARITY_CHECK port map( data => data_TB,
                                clk => CLK_TB,
                                init => init_TB,
										  Reset => Reset_TB,
                                err => err_TB
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
	
	Reset_TB <= '1';
	data_TB <= '0';
	init_TB <= '1';
	
	wait for CLK_PERIOD;
	
	Reset_TB <= '0';
	
	wait for CLK_PERIOD;
	
	init_TB <= '0';
	
	wait for CLK_PERIOD*4;
	
	init_TB <= '1'; --0
	
	wait for CLK_PERIOD;
	
	init_TB <= '0';
	data_TB <= '1';
	
	wait for CLK_PERIOD;
	
	data_TB <= '0';

	wait for CLK_PERIOD*3;
	
	init_TB <= '1'; --1	
	
	wait for CLK_PERIOD;

	init_TB <= '0';
	
	wait for CLK_PERIOD;
	
	data_TB <= '1';
	
	wait for CLK_PERIOD;
	
	data_TB <= '0';
	
	wait for CLK_PERIOD*2;
	
	init_TB <= '1'; --2

	wait for CLK_PERIOD;

	init_TB <= '0';	
	data_TB <= '1';
	
	wait for CLK_PERIOD*2;
	
	data_TB <= '0';
	
	wait for CLK_PERIOD*2;
	
	init_TB <= '1'; --3
	
	wait for CLK_PERIOD;

	init_TB <= '0';
	
	wait for CLK_PERIOD*2;
	
	data_TB <= '1';
	
	wait for CLK_PERIOD;
	
	init_TB <= '1'; --4
	data_TB <= '0';
	
	wait for CLK_PERIOD;
	
	init_TB <= '0';
	
	wait for CLK_PERIOD*3;
	
	init_TB <= '1';
	
	wait for CLK_PERIOD;
	
	wait; 
	
end process;

end architecture;
