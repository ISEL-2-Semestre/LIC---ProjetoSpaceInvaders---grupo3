library ieee;
use ieee.std_logic_1164.all;

entity SHIFT_REG_9_TB is 
end SHIFT_REG_9_TB;

architecture arc_SHIFT_REG_9_TB of SHIFT_REG_9_TB is

component SHIFT_REG_9
Port( D_9bit : in std_logic_vector(8 downto 0);
		PL : in std_logic;
		data : in std_logic;
		EN : in std_logic;
		clk : in std_logic;
		Clear : in std_logic;
		D : out std_logic_vector(8 downto 0);
		Sout : out std_logic
		);
End component;

signal D_9bit_TB : std_logic_vector(8 downto 0);
signal PL_TB : std_logic;
signal data_TB : std_logic;
signal EN_TB : std_logic;
signal Clear_TB : std_logic;
signal CLK_TB : std_logic;
signal D_TB : std_logic_vector(8 downto 0);
signal Sout_TB : std_logic;

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin
    
    UUT: SHIFT_REG_9 port map(	D_9bit => D_9bit_TB,
											PL => PL_TB,
											data => data_TB,
											EN => EN_TB,
											clk => CLK_TB,
											Clear => Clear_TB,
											D => D_TB,
											Sout => Sout_TB
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
	
	Clear_TB <= '1';
	D_9bit_TB <= "000000000";
	PL_TB <= '0';
	data_TB <= '0';
	EN_TB <= '1';
	
	wait for CLK_PERIOD;
	
	Clear_TB <= '0';
	PL_TB <= '1';
	
	wait for CLK_PERIOD;
	
	data_TB <= '1';
	
	wait for CLK_PERIOD*5;
	
	data_TB <= '0';	
	
	wait for CLK_PERIOD*3;
	
	data_TB <= '1';	
	
	wait for CLK_PERIOD*4;
	
	data_TB <= '0';	
	
	wait for CLK_PERIOD*2;
	
	data_TB <= '1';	
	
	wait for CLK_PERIOD;
	
	wait;
	
end process;

end architecture;	