LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity RING_BUFFER_TB is
end RING_BUFFER_TB;

architecture arc_RING_BUFFER_TB of RING_BUFFER_TB is

Component RING_BUFFER is
Port( D : in std_logic_vector(3 downto 0);
DAV : in std_logic;
CTS : in std_logic;
RESET : in std_logic;
CLK : in std_logic;
Q : out std_logic_vector(3 downto 0);
Wreg : out std_logic;
DAC : out std_logic);
end component;

signal CLK_TB : std_logic := '0';
signal RESET_TB, DAC_TB, CTS_TB, Wreg_TB, DAV_TB : std_logic;
signal Q_TB, D_TB : std_logic_vector(3 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

    CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
	 
	 UUT: RING_BUFFER port map(	CLK => CLK_TB,
										RESET => RESET_TB,
										DAC => DAC_TB,
										CTS => CTS_TB,
										Wreg => Wreg_TB,
										D => D_TB,
										Q => Q_TB,
										DAV => DAV_TB
										);

stimulus : process
begin

	RESET_TB <= '1';
	DAV_TB <= '0';
	CTS_TB <= '0';
	D_TB <= "1010";
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';

	wait for MCLK_PERIOD;

	CTS_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	DAV_TB <= '1';	
	
	wait for MCLK_PERIOD*7;
	
	DAV_TB <= '0';
	
	wait for MCLK_PERIOD*2;
	
	CTS_TB <= '1';
	
	wait for MCLK_PERIOD*2;
	
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	DAV_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	CTS_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	DAV_TB <= '0';
	CTS_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	wait;
end process;
	
end architecture;