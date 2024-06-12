LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SERIAL_RECEIVER_SSC_TB is
end SERIAL_RECEIVER_SSC_TB;

Architecture arc_SERIAL_RECEIVER_SSC_TB of SERIAL_RECEIVER_SSC_TB is

Component SERIAL_RECEIVER_SSC is
Port(	SDX 	  : in std_logic;
		SCLK	  : in std_logic;
		nSS 	  : in std_logic;
		accept  : in std_logic;
		RESET	  : in std_logic;
		D	 	  : out std_logic_vector(6 downto 0);
		DXval   : out std_logic
		);
end component;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal SDX_TB : std_logic;
signal nSS_TB : std_logic;
signal SCLK_TB : std_logic;
signal RESET_TB : std_logic;
signal accept_TB : std_logic;
signal D_TB : std_logic_vector(6 downto 0);
signal DXval_TB : std_logic;

begin

UUT: SERIAL_RECEIVER_SSC 
		port map(SDX => SDX_TB,
					SCLK => SCLK_TB,
					nSS => nSS_TB,
					accept => accept_TB,
					RESET => RESET_TB,
					D => D_TB,
					DXval => DXval_TB);

clk_gen : process
begin
		SCLK_TB <= '1';
		wait for MCLK_HALF_PERIOD;
		SCLK_TB <= '0';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process 
begin

	accept_TB <= '0';
	SDX_TB <= '0';
	nSS_TB <= '0';
	RESET_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	nSS_TB <= '1';
	
	wait for MCLK_PERIOD*4;

	SDX_TB <= '1';
	nSS_TB <= '0';
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '0';
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '1';
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '0';

	wait for MCLK_PERIOD;
	
	accept_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	nSS_TB <= '1';
	
	wait for MCLK_PERIOD*4;

	SDX_TB <= '1';
	nSS_TB <= '0';
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '0';
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '1';
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '0';

	wait for MCLK_PERIOD;
	
	accept_TB <= '1';	

	wait;
	
	end process;
	
	end architecture;