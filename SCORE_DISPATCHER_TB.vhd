LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SCORE_DISPATCHER_TB is
end SCORE_DISPATCHER_TB;

Architecture arc_SCORE_DISPATCHER_TB of SCORE_DISPATCHER_TB is

Component SCORE_DISPATCHER is
Port(	Dval : in std_logic;
		Din : in std_logic_vector(6 downto 0);
		RESET : in std_logic;
		CLK : in std_logic;
		WrD : out std_logic;
		Dout : out std_logic_vector(6 downto 0);
		done : out std_logic);
end component;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal Dval_TB : std_logic;
signal Din_TB : std_logic_vector(6 downto 0);
signal CLK_TB : std_logic;
signal RESET_TB : std_logic;
signal WrD_TB : std_logic;
signal Dout_TB : std_logic_vector(6 downto 0);
signal done_TB : std_logic;

begin

UUT: SCORE_DISPATCHER
		port map(Dval => Dval_TB,
					Din => Din_TB,
					CLK => CLK_TB,
					RESET => RESET_TB,
					WrD => WrD_TB,
					Dout => Dout_TB,
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
	Din_TB <= "0000000";
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';

	wait for MCLK_PERIOD;

	Dval_TB <= '1';
	
	wait for MCLK_PERIOD*3;

	Dval_TB <= '0';	
	Din_TB <= "0101010";
	
	wait for MCLK_PERIOD;
	
	Dval_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	wait;
end process;

end architecture;