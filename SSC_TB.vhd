LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SSC_TB is
end SSC_TB;

Architecture arc_SSC_TB of SSC_TB is

Component SSC is
Port( nSCsel : in std_logic;
		SCLK : in std_logic;
		SDX : in std_logic;
		RESET : in std_logic;
		Wrd : out std_logic;
		Dout : out std_logic_vector(6 downto 0)
		);
end component;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal nSCsel_TB : std_logic;
signal CLK_TB : std_logic;
signal SDX_TB : std_logic;
signal RESET_TB : std_logic;
signal Wrd_TB : std_logic;
signal Dout_TB : std_logic_vector(6 downto 0);

begin

UUT: SSC
		port map(nSCsel => nSCsel_TB,
					SCLK => CLK_TB,
					SDX => SDX_TB,
					RESET => RESET_TB,
					Wrd => Wrd_TB,
					Dout => Dout_TB
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
	nSCsel_TB <= '0';
	SDX_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';
	nSCsel_TB <= '1';

	wait for MCLK_PERIOD;

	SDX_TB <= '1';
	
	wait for MCLK_PERIOD*3;

	SDX_TB <= '0';	
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '1';
	
	wait for MCLK_PERIOD*5;
	
	SDX_TB <= '0';	
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '1';
	
	wait for MCLK_PERIOD*2;
	
	SDX_TB <= '0';	
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '1';
	
	wait for MCLK_PERIOD*2;
	
	SDX_TB <= '0';	
	
	wait for MCLK_PERIOD*4;
	
	SDX_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	wait;
end process;

end architecture;
