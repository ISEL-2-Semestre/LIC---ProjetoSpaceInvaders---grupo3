LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SPACE_INVADERS is
Port( RESET, CLK, ACK, nSCsel, nLCDsel, SDX : in std_logic;
		LIN : in std_logic_vector(3 downto 0);
		Wrd, Wrl, Dval : out std_logic;
      COL : out std_logic_vector(2 downto 0);
		Q : out std_logic_vector(3 downto 0);
		DoutSSC : out std_logic_vector(6 downto 0);
		DoutLCD : out std_logic_vector(8 downto 0)
		);
End SPACE_INVADERS;

Architecture structural of SPACE_INVADERS is
Component SSC is
Port( nSCsel : in std_logic;
		SCLK : in std_logic;
		SDX : in std_logic;
		RESET : in std_logic;
		Wrd : out std_logic;
		Dout : out std_logic_vector(6 downto 0)
		);
End Component;

Component SLCDC is
Port( nLCDsel : in std_logic;
		SCLK : in std_logic;
		SDX : in std_logic;
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

Begin

U1: SSC port map(nSCsel => nSCsel, SCLK => CLK, SDX => SDX, RESET => RESET, Wrd => Wrd, Dout => DoutSSC);
U2: SLCDC port map(nLCDsel => nLCDsel, SCLK => CLK, SDX => SDX, RESET => RESET, Wrl => Wrl, Dout => DoutLCD);
U3: KEYBOARD_READER port map(LIN => LIN, ACK => ACK, CLK => CLK, RESET => RESET, COL => COL, Q => Q, Dval => Dval);

End structural;