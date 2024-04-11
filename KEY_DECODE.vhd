LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KEY_DECODE is
port( CLK, RESET, Kack : in std_logic;
		LIN : in std_logic_vector(3 downto 0);
		COL : out std_logic_vector (2 downto 0);
		K : out std_logic_vector(3 downto 0);
		Kval : out std_logic);
end KEY_DECODE;

Architecture structural of KEY_DECODE is
Component KEY_SCAN is
Port( Kscan : in std_logic;
		Clk : in std_logic;
		Reset : in std_logic;
		lin0, lin1, lin2, lin3 : in std_logic;
		Dout : out std_logic_vector(2 downto 0);
		Kpress : out std_logic;
		K : out std_logic_vector(3 downto 0)
		);
end component;

Component CLK_DIV is
generic(div: natural := 50000000);
port( clk_in: in std_logic;
		clk_out: out std_logic);
end component;

Component KEY_CONTROL is
Port( Kack, Kpress, CLK, RESET : in std_logic;
		Kscan, Kval : out std_logic
		);
end component;

signal carry_Kscan : std_logic;
signal carry_CLK : std_logic;
signal carry_Kpress : std_logic;


Begin

U1 : KEY_CONTROL port map(	Kack => Kack, Kpress => carry_Kpress, CLK => carry_CLK, RESET => RESET, 
									Kscan => carry_Kscan, Kval => Kval);

U2 : KEY_SCAN 	port map(	Kscan => carry_Kscan, CLK => carry_CLK, Reset => RESET, lin0 => LIN(0), lin1 => LIN(1),
									lin2 => LIN(2), lin3 => LIN(3), Dout => COL, Kpress => carry_Kpress, K => K);
								
U3 : CLK_DIV 	port map( 	clk_in => CLK , clk_out => carry_CLK);
									
									
end structural;