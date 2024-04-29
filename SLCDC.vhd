LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SLCDC is
Port( nLCDsel : in std_logic;
		SCLK : in std_logic;
		SDX : in std_logic;
		RESET : in std_logic;
		Wrl : out std_logic;
		Dout : out std_logic_vector(8 downto 0)
		);
End SLCDC;

Architecture structural of SLCDC is
Component SERIAL_RECEIVER is
Port( SDX: in std_logic;
		SCLK: in std_logic;
		nSS: in std_logic;
		accept: in std_logic;
		RESET: in std_logic;
		D: out std_logic_vector(8 downto 0);
		DXval: out std_logic
		);
End Component;

Component LCD_DISPATCHER is
Port( Dval : in std_logic;
		Din : in std_logic_vector(8 downto 0);
		RESET : in std_logic;
		CLK : in std_logic;
		Wrl : out std_logic;
		Dout : out std_logic_vector(8 downto 0);
		done : out std_logic
		);
End Component;

signal carry_Dval : std_logic;
signal carry_Din : std_logic_vector(8 downto 0);
signal carry_done : std_logic;

Begin

U1: SERIAL_RECEIVER port map(SDX => SDX, SCLK => SCLK, nSS => nLCDsel, accept => carry_done,
 RESET => RESET, D => carry_Din, DXval => carry_Dval);
U2: LCD_DISPATCHER port map(Dval => carry_Dval, Din => carry_Din, RESET => RESET, CLK => SCLK,
Wrl => Wrl, Dout => Dout, done => carry_done);
 
End structural;