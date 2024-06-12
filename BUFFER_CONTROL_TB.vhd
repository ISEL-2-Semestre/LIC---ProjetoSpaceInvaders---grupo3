LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity BUFFER_CONTROL_TB is
end BUFFER_CONTROL_TB;

architecture arc_BUFFER_CONTROL_TB of BUFFER_CONTROL_TB is

Component BUFFER_CONTROL is
Port(	Load		: in std_logic;
		ACK		: in std_logic;
		CLK		: in std_logic;
		RESET 	: in std_logic;
		Wreg		: out std_logic;
		OBfree 	: out std_logic;
		Dval 		: out std_logic);
end component;

signal RESET_TB, CLK_TB, Load_TB, ACK_TB, Wreg_TB, OBfree_TB, Dval_TB : std_logic;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin
	 
	 UUT: BUFFER_CONTROL port map(	CLK => CLK_TB,
										RESET => RESET_TB,
										Load => Load_TB,
										OBfree => OBfree_TB,
										Wreg => Wreg_TB,
										ACK => ACK_TB,
										Dval => Dval_TB
										);
										
clk_gen : process
begin
		CLK_TB <= '1';
		wait for MCLK_HALF_PERIOD;
		CLK_TB <= '0';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus : process
begin

	RESET_TB <= '1';
	Load_TB <= '0';
	ACK_TB <= '0';
	
	wait for CLK_PERIOD;
	
	RESET_TB <= '0';

	wait for CLK_PERIOD;

	Load_TB <= '1';
	
	wait for CLK_PERIOD*2;
	
	ACK_TB <= '1';
	Load_TB <= '0';
	
	wait for CLK_PERIOD*2;
	
	ACK_TB <= '0';
	Load_TB <= '1';	
	
	wait for CLK_PERIOD*2;
	
	Load_TB <= '0';
	ACK_TB <= '1';
	
	wait for CLK_PERIOD;
	
	ACK_TB <= '0';
	
	wait for CLK_PERIOD;
	
	ACK_TB <= '1';
	
	wait for CLK_PERIOD;
	
	ACK_TB <= '0';
	
	wait;
	
end process;
	
end architecture;
