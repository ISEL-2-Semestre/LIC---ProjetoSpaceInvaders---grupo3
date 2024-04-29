LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity LCD_DISPATCHER is
Port( Dval : in std_logic;
		Din : in std_logic_vector(8 downto 0);
		RESET : in std_logic;
		CLK : in std_logic;
		Wrl : out std_logic;
		Dout : out std_logic_vector(8 downto 0);
		done : out std_logic
		);
End LCD_DISPATCHER;

Architecture structural of LCD_DISPATCHER is
Component LCD_D_CONTROL is
Port( Dval : in std_logic;
		CLK : in std_logic;
		RESET : in std_logic;
		Wrl : out std_logic;
		done : out std_logic
		);
End Component;

Begin

U1: LCD_D_CONTROL port map(Dval => Dval, CLK => CLK, RESET => RESET, Wrl => Wrl, done => done);

Dout <= Din;

End structural;