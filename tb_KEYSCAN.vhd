LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_KEYSCAN IS
END tb_KEYSCAN;

ARCHITECTURE behavior OF tb_KEYSCAN IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT KEYSCAN
    PORT(
         Kscan : IN  std_logic;
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         lin0, lin1, lin2, lin3 : IN  std_logic;
         Dout : OUT  std_logic_vector(2 downto 0);
         Kpress : OUT std_logic;
         K : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal Kscan : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal lin0, lin1, lin2, lin3 : std_logic := '0';

    --Outputs
   signal Dout : std_logic_vector(2 downto 0);
   signal Kpress : std_logic;
   signal K : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: KEYSCAN PORT MAP (
          Kscan => Kscan,
          Clk => Clk,
          Reset => Reset,
          lin0 => lin0,
          lin1 => lin1,
          lin2 => lin2,
          lin3 => lin3,
          Dout => Dout,
          Kpress => Kpress,
          K => K
        );

   -- Clock process definitions
   clk_process :process
   begin
		Clk <= '0'; wait for clk_period/2;
		Clk <= '1'; wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin
      wait for clk_period*10;
      Reset <= '1'; wait for clk_period*2;
      Reset <= '0'; wait for clk_period*2;
      Kscan <= '1'; wait for clk_period*2;
      Kscan <= '0'; wait for clk_period*2;
      -- Add more stimulus here
      wait;
   end process;

END;
