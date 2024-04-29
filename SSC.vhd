LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SSC is
Port( nSCsel : in std_logic;
		SCLK : in std_logic;
		SDX : in std_logic;
		RESET : in std_logic;
		Wrd : out std_logic;
		Dout : out std_logic_vector(6 downto 0)
		);
End SSC;

Architecture structural of SSC is
Component SERIAL_RECIEVER_SSC is
Port( SDX: in std_logic;
		SCLK: in std_logic;
		nSS: in std_logic;
		accept: in std_logic;
		RESET: in std_logic;
		D: out std_logic_vector(6 downto 0);
		DXval: out std_logic
		);
End Component;

Component SCORE_DISPATCHER is
Port( Dval : in std_logic;
		Din : in std_logic_vector(6 downto 0);
		RESET : in std_logic;
		CLK : in std_logic;
		Wrd : out std_logic;
		Dout : out std_logic_vector(6 downto 0);
		done : out std_logic
		);
End Component;

signal carry_Dval : std_logic;
signal carry_Din : std_logic_vector(6 downto 0);
signal carry_done : std_logic;

Begin

U1: SERIAL_RECEIVER_SSC port map(SDX => SDX, SCLK => SCLK, nSS => nSCsel, accept => carry_done,
 RESET => RESET, D => carry_Din, DXval => carry_Dval);
U2: SCORE_DISPATCHER port map(Dval => carry_Dval, Din => carry_Din, RESET => RESET, CLK => SCLK,
Wrd => Wrd, Dout => Dout, done => carry_done);

End structural;
