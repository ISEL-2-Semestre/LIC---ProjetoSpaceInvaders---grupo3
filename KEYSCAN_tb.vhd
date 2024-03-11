LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY KEYSCAN_tb IS
END KEYSCAN_tb;

ARCHITECTURE arc_KEYSCAN_tb OF KEYSCAN_tb IS

    COMPONENT KEYSCAN
    PORT(
        Kscan : IN std_logic;
        Clk : IN std_logic;
        Reset : IN std_logic;
        lin0, lin1, lin2, lin3 : IN std_logic;
        Dout : OUT std_logic_vector(2 downto 0);
        Kpress : OUT std_logic;
        K : OUT std_logic_vector(3 downto 0)
    );
    END COMPONENT;

    SIGNAL Kscan_TB, Clk_TB, Reset_TB, lin0_TB, lin1_TB, lin2_TB, lin3_TB: std_logic;
    SIGNAL Dout_TB: std_logic_vector(2 downto 0);
    SIGNAL Kpress_TB: std_logic;
    SIGNAL K_TB: std_logic_vector(3 downto 0);

BEGIN
    U1: KEYSCAN PORT MAP(Kscan => Kscan_TB, Clk => Clk_TB, Reset => Reset_TB, lin0 => lin0_TB, lin1 => lin1_TB, lin2 => lin2_TB, lin3 => lin3_TB, Dout => Dout_TB, Kpress => Kpress_TB, K => K_TB);

    PROCESS 
    BEGIN
        -- Initialize signals
        Kscan_TB <= '0';
        Clk_TB <= '0';
        Reset_TB <= '1';
        lin0_TB <= '0';
        lin1_TB <= '0';
        lin2_TB <= '0';
        lin3_TB <= '0';

        WAIT FOR 10 ns;

        -- Apply test vectors
        Reset_TB <= '0';
        Clk_TB <= '1';
        Kscan_TB <= '1';
        lin0_TB <= '1';
        lin1_TB <= '0';
        lin2_TB <= '0';
        lin3_TB <= '0';

        WAIT FOR 10 ns;

        Kscan_TB <= '0';
        lin0_TB <= '0';
        lin1_TB <= '1';

        WAIT FOR 10 ns;

        Kscan_TB <= '1';
        lin1_TB <= '0';
        lin2_TB <= '1';

        WAIT FOR 10 ns;

        Kscan_TB <= '0';
        lin2_TB <= '0';
        lin3_TB <= '1';

        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;

END arc_KEYSCAN_tb;
