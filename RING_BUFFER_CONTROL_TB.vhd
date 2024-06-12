LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity RING_BUFFER_CONTROL_TB is
end RING_BUFFER_CONTROL_TB;

Architecture arc_RING_BUFFER_CONTROL_TB of RING_BUFFER_CONTROL_TB is

Component RING_BUFFER_CONTROL is
Port(	DAV	: in std_logic;
		full	: in std_logic;
		empty	: in std_logic;
		CTS	: in std_logic;
		CLK	: in std_logic;
		RESET : in std_logic;
		incPut: out std_logic;
		incGet: out std_logic;
		Wr		: out std_logic;
		selPG : out std_logic;
		Wreg 	: out std_logic;
		DAC	: out std_logic);
end component;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal DAV_TB : std_logic;
signal full_TB : std_logic;
signal empty_TB : std_logic;
signal CTS_TB : std_logic;
signal CLK_TB : std_logic;
signal RESET_TB : std_logic;
signal incPut_TB : std_logic;
signal incGet_TB : std_logic;
signal Wr_TB : std_logic;
signal selPG_TB : std_logic;
signal Wreg_TB : std_logic;
signal DAC_TB : std_logic;


begin

UUT: RING_BUFFER_CONTROL
		port map(DAV => DAV_TB,
					full => full_TB,
					empty => empty_TB,
					CTS => CTS_TB,
					CLK => CLK_TB,
					RESET => RESET_TB,
					incPut => incPut_TB,
					incGet => incGet_TB,
					Wr => Wr_TB,
					selPG => selPG_TB,
					Wreg => Wreg_TB,
					DAC => DAC_TB);

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
	DAV_TB <= '0';
	full_TB <= '0';
	empty_TB <= '0';
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';

	wait for MCLK_PERIOD;

	empty_TB <= '1';
	CTS_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	empty_TB <= '0';
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	DAV_TB <= '1';
	full_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	full_TB <= '0';
	
	wait for MCLK_PERIOD*6;
	
	DAV_TB <= '0';
	
	wait for MCLK_PERIOD*2;
	
	CTS_TB <= '1';
	
	wait for MCLK_PERIOD*2;
	
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	DAV_TB <= '1';
	full_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	CTS_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	DAV_TB <= '0';
	full_TB <= '0';
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	wait;
end process;

end architecture;