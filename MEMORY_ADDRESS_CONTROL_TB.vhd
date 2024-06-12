LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity MEMORY_ADDRESS_CONTROL_TB is
end MEMORY_ADDRESS_CONTROL_TB;

Architecture arc_MEMORY_ADDRESS_CONTROL_TB of MEMORY_ADDRESS_CONTROL_TB is

Component MEMORY_ADDRESS_CONTROL is
Port( putGet : in std_logic;
        incPut : in std_logic;
        incGet : in std_logic;
        RESET : in std_logic;
		  CLK : in std_logic;
        A : out std_logic_vector(2 downto 0);
        full : out std_logic;
        empty : out std_logic
        );
End Component;


constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;

signal putGet_TB : std_logic;
signal incPut_TB : std_logic;
signal CLK_TB : std_logic;
signal RESET_TB : std_logic;
signal incGet_TB : std_logic;
signal A_TB : std_logic_vector(2 downto 0);
signal full_TB : std_logic;
signal empty_TB : std_logic;

begin

UUT: MEMORY_ADDRESS_CONTROL 
		port map(putGet => putGet_TB,
					incPut => incPut_TB,
					CLK => CLK_TB,
					RESET => RESET_TB,
					incGet => incGet_TB,
					A => A_TB,
					full => full_TB,
					empty => empty_TB);

clk_gen : process
begin
		CLK_TB <= '1';
		wait for MCLK_HALF_PERIOD;
		CLK_TB <= '0';
		wait for MCLK_HALF_PERIOD;
end process;

stimulus: process 
begin

	putGet_TB <= '1';
	incPut_TB <= '0';
	incGet_TB <= '0';
	RESET_TB <= '1';
	
	wait for MCLK_PERIOD;
	
	RESET_TB <= '0';
	
	wait for MCLK_PERIOD;
	
	incPut_TB <= '1';
	
	wait for MCLK_PERIOD*4;
	
	incPut_TB <= '0';
	incGet_TB <= '1';
	putGet_TB <= '0';
	
	wait for MCLK_PERIOD*2;
	
	incPut_TB <= '1';
	incGet_TB <= '0';
	putGet_TB <= '1';
	
	wait for MCLK_PERIOD*5;
	
	incPut_TB <= '0';
	incGet_TB <= '1';
	putGet_TB <= '0';
	
	wait for MCLK_PERIOD*7;
	
	incPut_TB <= '1';
	incGet_TB <= '0';
	putGet_TB <= '1';
	
	wait for MCLK_PERIOD*7;
	
	incPut_TB <= '0';
	incGet_TB <= '0';
	putGet_TB <= '0';
	
	wait;
	
	end process;
	
	end architecture;
