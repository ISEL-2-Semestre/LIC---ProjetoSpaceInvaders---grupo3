LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SERIAL_CONTROL_tb is
end SERIAL_CONTROL_tb;

Architecture arc_SERIAL_CONTROL_tb of SERIAL_CONTROL_tb is

Component SERIAL_CONTROL is
Port(	nenRx, accept, CLK, pFlag, dFlag, RXerror, RESET : in std_logic;
		wr, init, DXval : out std_logic
		);
end component;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal nenRx_tb : std_logic;
signal accept_tb : std_logic;
signal CLK_tb : std_logic;
signal RESET_tb : std_logic;
signal pFlag_tb : std_logic;
signal dFlag_tb : std_logic;
signal RXerror_tb : std_logic;
signal wr_tb : std_logic;
signal init_tb : std_logic;
signal DXval_tb : std_logic;


begin

UUT: SERIAL_CONTROL
		port map(nenRx => nenRx_tb,
					accept => accept_tb,
					CLK => CLK_tb,
					pFlag => pFlag_tb,
					dFlag => dFlag_tb,
					RXerror => RXerror_tb,
					RESET => RESET_tb,
					wr => wr_tb,
					init => init_tb,
					DXval => DXval_tb);

clk_gen : process
begin
		CLK_tb <= '1';
		wait for MCLK_HALF_PERIOD;
		CLK_tb <= '0';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process 
begin

	RESET_tb <= '1';
	accept_tb <= '0';
	nenRx_tb <= '0';
	pFlag_tb <= '0';
	dFlag_tb <= '0';
	RXerror_tb <= '0';
	
	wait for MCLK_PERIOD;
	
	RESET_tb <= '0';
	
	wait for MCLK_PERIOD;

	nenRx_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	nenRx_tb <= '0';
	
	wait for MCLK_PERIOD;
	
	dFlag_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	dFlag_tb <= '0';	
	
	wait for MCLK_PERIOD;
	
	RXerror_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	pFlag_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	RXerror_tb <= '0';
	pFlag_tb <= '0';
	
	wait for MCLK_PERIOD;
	
	accept_tb <= '1';
	
	wait for MCLK_PERIOD;

	wait;
end process;

end architecture;