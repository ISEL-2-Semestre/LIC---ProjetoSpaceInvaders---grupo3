LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity OUTPUT_BUFFER_TB is
end OUTPUT_BUFFER_TB;

architecture arc_OUTPUT_BUFFER_TB of OUTPUT_BUFFER_TB is

Component OUTPUT_BUFFER is
Port( D : in std_logic_vector(3 downto 0);
		Load : in std_logic;
		ACK : in std_logic;
		RESET : in std_logic;
		CLK : in std_logic;
		Q : out std_logic_vector(3 downto 0);
		OBfree : out std_logic;
		Dval : out std_logic);
end component;

signal CLK_TB : std_logic := '0';
signal RESET_TB, Load_TB, ACK_TB, Dval_TB, OBfree_TB : std_logic;
signal Q_TB, D_TB : std_logic_vector(3 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

    CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
	 
	 UUT: OUTPUT_BUFFER port map(	CLK => CLK_TB,
										RESET => RESET_TB,
										Load => Load_TB,
										ACK => ACK_TB,
										Dval => Dval_TB,
										D => D_TB,
										Q => Q_TB,
										OBfree => OBfree_TB
										);

stimulus : process
begin

	RESET_TB <= '1';
	ACK_TB <= '0';
	Load_TB <= '0';
	D_TB <= "1010";
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	Load_TB <= '1';	
	
	wait for MCLK_PERIOD;
	
	Load_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	ACK_TB <= '1';
	
	wait for MCLK_PERIOD*2;
	
	D_TB <= "1011";
	
	wait for MCLK_PERIOD;
	
	ACK_TB <= '0';
	Load_TB <= '1';	
	
	wait for MCLK_PERIOD;
	
	Load_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	ACK_TB <= '1';
	
	wait for MCLK_PERIOD*2;
	
	wait;
end process;
	
end architecture;