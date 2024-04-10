LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KEY_SCAN_TB is
end KEY_SCAN_TB;

architecture arc_KEY_SCAN_TB of KEY_SCAN_TB is

component KEY_SCAN
Port( Kscan : in std_logic;
        Clk : in std_logic;
        Reset : in std_logic;
        lin0, lin1, lin2, lin3 : in std_logic;
        Dout : out std_logic_vector(2 downto 0);
        Kpress : out std_logic;
        K : out std_logic_vector(3 downto 0)
        );
end component;

signal CLK_TB : std_logic := '0';
signal K_TB : std_logic_vector(3 downto 0);
signal RESET_TB, Kscan_TB, lin0_TB, lin1_TB, lin2_TB, lin3_TB, Kpress_TB : std_logic;
signal Dout_TB : std_logic_vector(2 downto 0);

constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD / 2;
constant CLK_PERIOD : time := 20 ns;

begin

    CLK_TB <= not CLK_TB after MCLK_HALF_PERIOD;
    
    UUT: KEY_SCAN port map(    Kscan => Kscan_TB,
                                Clk => CLK_TB,
                                Reset => RESET_TB,
                                lin0 => lin0_TB,
                                lin1 => lin1_TB,
                                lin2 => lin2_TB,
                                lin3 => lin3_TB,
                                Dout => Dout_TB,
                                Kpress => Kpress_TB,
                                K => K_TB
    );
    
stimulus: process 
begin

    RESET_TB <= '1';
    Kscan_TB <= '1';
    lin0_TB <= '1';
    lin1_TB <= '1';
    lin2_TB <= '1';
    lin3_TB <= '1';
	 
    wait for CLK_PERIOD*2;
    
    RESET_TB <= '0';
    
    wait for CLK_PERIOD*2;
    
    lin0_TB <= '1';
    
    wait for CLK_PERIOD*8;
    
    lin0_TB <= '0';
    lin1_TB <= '1';
    
    wait for CLK_PERIOD*8;
    
    lin1_TB <= '0';
    lin2_TB <= '1';
    
    wait for CLK_PERIOD*8;
    
    lin2_TB <= '0';
    lin3_TB <= '1';
    
    wait for CLK_PERIOD*8;
    
    lin1_TB <= '1';
    
    wait for CLK_PERIOD*8;
    
    lin1_TB <= '0';
    lin3_TB <= '0';
    lin2_TB <= '1';
    lin0_TB <= '1';
    
    wait for CLK_PERIOD*4;
    
end process;

end architecture;