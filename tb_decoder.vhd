LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_decoder IS
END tb_decoder;

ARCHITECTURE behavior OF tb_decoder IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT DECODER
    PORT(
         S1 : IN  std_logic;
         S0 : IN  std_logic;
         Q0 : OUT  std_logic;
         Q1 : OUT  std_logic;
         Q2 : OUT  std_logic;
         Q3 : OUT  std_logic
        );
    END COMPONENT;

   --Inputs
   signal S1 : std_logic := '0';
   signal S0 : std_logic := '0';

    --Outputs
   signal Q0 : std_logic;
   signal Q1 : std_logic;
   signal Q2 : std_logic;
   signal Q3 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: DECODER PORT MAP (
          S1 => S1,
          S0 => S0,
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3
        );

   -- Clock process definitions
   clk_process :process
   begin
		S1 <= '0'; S0 <= '0'; wait for clk_period*2;  -- 00
		S1 <= '0'; S0 <= '1'; wait for clk_period*2;  -- 01
		S1 <= '1'; S0 <= '0'; wait for clk_period*2;  -- 10
		S1 <= '1'; S0 <= '1'; wait for clk_period*2;  -- 11
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;  
   end process;

END;
