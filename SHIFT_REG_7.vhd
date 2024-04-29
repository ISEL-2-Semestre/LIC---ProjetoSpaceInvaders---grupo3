library ieee;
use ieee.std_logic_1164.all;

entity SHIFT_REG_7 is
Port( D_7bit : in std_logic_vector(6 downto 0);
		PL : in std_logic;
		data : in std_logic;
		EN : in std_logic;
		clk : in std_logic;
		Clear : in std_logic;
		D : out std_logic_vector(6 downto 0);
		Sout : out std_logic
		);
End SHIFT_REG_7;
	
Architecture structure of SHIFT_REG_7 is
Component FFD is
Port( CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
End Component;

Component MUX is
Port( A : in std_logic;
		B : in std_logic;
		S : in std_logic;
		Y : out std_logic);
End Component;

signal carry_MUX0 : std_logic;
signal carry_MUX1 : std_logic;
signal carry_MUX2 : std_logic;
signal carry_MUX3 : std_logic;
signal carry_MUX4 : std_logic;
signal carry_MUX5 : std_logic;
signal carry_MUX6 : std_logic;
signal carry_D6 : std_logic;
signal carry_D5 : std_logic;
signal carry_D4 : std_logic;
signal carry_D3 : std_logic;
signal carry_D2 : std_logic;
signal carry_D1 : std_logic;
signal carry_D0 : std_logic;


Begin 

U1 : MUX port map (A => D_7bit(6), B => Data, S => PL, Y => carry_MUX6);
U2 : FFD port map (CLK => clk, RESET => Clear, SET => '0', D => carry_MUX6, EN => EN, Q => carry_D6);
U3 : MUX port map (A => D_7bit(5), B => carry_D6, S => PL, Y => carry_MUX5);
U4 : FFD port map (CLK => clk, RESET => Clear, SET => '0', D => carry_MUX5, EN => EN, Q => carry_D5);
U5 : MUX port map (A => D_7bit(4), B => carry_D5, S => PL, Y => carry_MUX4);
U6 : FFD port map (CLK => clk, RESET => Clear, SET => '0', D => carry_MUX4, EN => EN, Q => carry_D4);
U7 : MUX port map (A => D_7bit(3), B => carry_D4, S => PL, Y => carry_MUX3);
U8 : FFD port map (CLK => clk, RESET => Clear, SET => '0', D => carry_MUX3, EN => EN, Q => carry_D3);
U9 : MUX port map (A => D_7bit(2), B => carry_D3, S => PL, Y => carry_MUX2);
U10 : FFD port map (CLK => clk, RESET => Clear, SET => '0', D => carry_MUX2, EN => EN, Q => carry_D2);
U11 : MUX port map (A => D_7bit(1), B => carry_D2, S => PL, Y => carry_MUX1);
U12 : FFD port map (CLK => clk, RESET => Clear, SET => '0', D => carry_MUX1, EN => EN, Q => carry_D1);
U13 : MUX port map (A => D_7bit(0), B => carry_D1, S => PL, Y => carry_MUX0);
U14 : FFD port map (CLK => clk, RESET => Clear, SET => '0', D => carry_MUX0, EN => EN, Q => carry_D0);

D(0) <= carry_D0;
D(1) <= carry_D1;
D(2) <= carry_D2;
D(3) <= carry_D3;
D(4) <= carry_D4;
D(5) <= carry_D5;
D(6) <= carry_D6;

Sout <= carry_D0;

End structure;