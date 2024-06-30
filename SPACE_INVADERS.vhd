LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SPACE_INVADERS is
Port( RESET, CLK, M, Coin : in std_logic;
		LIN : in std_logic_vector(3 downto 0);
		Wrl, accept : out std_logic;
      COL : out std_logic_vector(2 downto 0);
		DoutLCD : out std_logic_vector(8 downto 0);
		HEX0	: out std_logic_vector(7 downto 0);
		HEX1	: out std_logic_vector(7 downto 0);
		HEX2	: out std_logic_vector(7 downto 0);
		HEX3	: out std_logic_vector(7 downto 0);
		HEX4	: out std_logic_vector(7 downto 0);
		HEX5	: out std_logic_vector(7 downto 0)
		);
End SPACE_INVADERS;

Architecture structural of SPACE_INVADERS is
Component SSC is
Port( nSCsel : in std_logic;
		SCLK : in std_logic;
		CLK : in std_logic;
		SDX : in std_logic;
		RESET : in std_logic;
		HEX0	: out std_logic_vector(7 downto 0);
		HEX1	: out std_logic_vector(7 downto 0);
		HEX2	: out std_logic_vector(7 downto 0);
		HEX3	: out std_logic_vector(7 downto 0);
		HEX4	: out std_logic_vector(7 downto 0);
		HEX5	: out std_logic_vector(7 downto 0)
		);
End Component;

Component SLCDC is
Port( nLCDsel : in std_logic;
		SCLK : in std_logic;
		SDX : in std_logic;		
		CLK : in std_logic;
		RESET : in std_logic;
		Wrl : out std_logic;
		Dout : out std_logic_vector(8 downto 0)
		);
End Component;
		
Component KEYBOARD_READER is
Port( LIN : in std_logic_vector(3 downto 0);
      ACK : in std_logic;
      CLK : in std_logic;
      RESET : in std_logic;
      COL : out std_logic_vector(2 downto 0);
      Q : out std_logic_vector(3 downto 0);
		Dval : out std_logic
      );
End component;

Component UsbPort is 
	PORT
	(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
end component;

signal carry_input, carry_output : std_logic_vector(7 downto 0);

Begin

U1: SSC port map(nSCsel => carry_output(1), SCLK => carry_output(4), CLK => CLK, SDX => carry_output(3), RESET => RESET, HEX0 => HEX0, HEX1 => HEX1, HEX2 => HEX2, HEX3 => HEX3, HEX4 => HEX4, HEX5 => HEX5);
U2: SLCDC port map(nLCDsel => carry_output(0), SCLK => carry_output(4), CLK => CLK, SDX => carry_output(3), RESET => RESET, Wrl => Wrl, Dout => DoutLCD);
U3: KEYBOARD_READER port map(LIN => LIN, ACK => carry_output(7), CLK => CLK, RESET => RESET, COL => COL, Q => carry_input(3 downto 0), Dval => carry_input(4));
U4: UsbPort port map(inputPort => carry_input, outputPort => carry_output);

carry_input(7) <= M;
carry_input(6) <= Coin;
accept <= carry_output(6);

End structural;
