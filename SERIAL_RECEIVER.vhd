LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity SERIAL_RECEIVER is
Port( SDX 	  : in std_logic;
		SCLK	  : in std_logic;
		nSS 	  : in std_logic;
		accept  : in std_logic;
		RESET	  : in std_logic;
		D	 	  : out std_logic_vector(8 downto 0);
		DXval   : out std_logic
		);
End SERIAL_RECEIVER;

Architecture structural of SERIAL_RECEIVER is
Component SERIAL_CONTROL is
Port( nenRx   : in std_logic;
		accept  : in std_logic;
		pFlag   : in std_logic;
		dFlag	  : in std_logic;
		RXerror : in std_logic;
		RESET   : in std_logic;
		CLK 	  : in std_logic;
		wr 	  : out std_logic;
		init 	  : out std_logic;
		DXval   : out std_logic
		);
End Component;

Component PARITY_CHECK is
Port( data 	  : in std_logic;
		init 	  : in std_logic;
		CLK 	  : in std_logic;
		Reset	  : in std_logic;
		err 	  : out std_logic
		);
End Component;

Component COUNTER_UP is
Port( dataIn  : in std_logic_vector(3 downto 0);
      RESET   : in std_logic;
      PL 	  : in std_logic;
      CE 	  : in std_logic;
      CLK 	  : in std_logic;
      Q 		  : out std_logic_vector(3 downto 0)
		);
End Component;

Component SHIFT_REG_9 is
Port( D_9bit  : in std_logic_vector(8 downto 0);
      PL 	  : in std_logic;
      data 	  : in std_logic;
      EN 	  : in std_logic;
      clk 	  : in std_logic;
      Clear   : in std_logic;
      D 		  : out std_logic_vector(8 downto 0);
      Sout 	  : out std_logic
      );
End Component;

Component EQUAL_9 is
Port( D		  : in std_logic_vector(3 downto 0);
		Y		  : out std_logic
		);
End Component;

Component EQUAL_10 is
Port( D		  : in std_logic_vector(3 downto 0);
		Y		  : out std_logic
		);
End Component;

signal EQUALS_9  : std_logic;
signal EQUALS_10  : std_logic;
signal carry_err : std_logic;
signal carry_wr  : std_logic;
signal carry_init: std_logic;
signal carry_count: std_logic_vector(3 downto 0);

Begin

U1 : SERIAL_CONTROL port map( nenRx => nSS, accept => accept, pFlag => EQUALS_10, dFlag => EQUALS_9, RXerror => carry_err, RESET => RESET, CLK => SCLK, wr => carry_wr, init => carry_init, DXval => DXval);
U2 : PARITY_CHECK   port map( data => SDX, init => carry_init, CLK => SCLK, Reset => RESET, err => carry_err);
U3 : COUNTER_UP	  port map( dataIn => "0000", RESET => RESET, PL => carry_init, CE => '1', CLK => SCLK, Q => carry_count);
U4 : EQUAL_9		  port map( D => carry_count, Y => EQUALS_9);
U5 : EQUAL_10		  port map( D => carry_count, Y => EQUALS_10);
U6 : SHIFT_REG_9	  port map( D_9bit => "000000000", PL => '1', data => SDX, EN => carry_wr, clk => SCLK, Clear => RESET, D => D);

End structural;