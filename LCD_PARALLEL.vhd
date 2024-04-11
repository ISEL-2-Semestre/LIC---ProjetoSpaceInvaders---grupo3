library ieee;
use ieee.std_logic_1164.all;

entity LCD_PARALLEL is 
	port(
	D : out std_logic_vector(7 downto 0);
	E : out std_logic;
	RS: out std_logic
	);
end LCD_PARALLEL;

architecture LCD_PARALLEL_ARCH of LCD_PARALLEL is

component Reg is 
	port(
	D: in std_logic_vector(3 downto 0);
	CLK : in std_logic;
	EN : in std_logic;
	RESET: in std_logic;
	Q : out std_logic_vector(3 downto 0)
	);
end component;

component UsbPort IS 
	PORT
	(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END component;

signal carry_data: std_logic_vector(3 downto 0);
signal carry_D_0: std_logic_vector(3 downto 0);
signal carry_D_1: std_logic_vector(3 downto 0);
signal carry_CLK: std_logic;
signal carry_input: std_logic_vector(7 downto 0);	

begin

U1: UsbPort port map (inputPort => carry_input, outputPort(6) => RS, outputPort(5) => E, outputPort(4) => carry_CLK, outputPort(3 downto 0) => carry_data);

U2: Reg port map (D => carry_data, CLK => carry_CLK, EN => '1', RESET => '0', Q => carry_D_0);

U3: Reg port map (D => carry_D_0, CLK => carry_CLK, EN => '1', RESET => '0', Q => carry_D_1);

D(7 downto 4) <= carry_D_1;

D(3 downto 0) <= carry_D_0;

end LCD_PARALLEL_ARCH;