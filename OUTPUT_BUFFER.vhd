LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity OUTPUT_BUFFER is
Port( D : in std_logic_vector(3 downto 0);
		Load : in std_logic;
		ACK : in std_logic;
		RESET : in std_logic;
		CLK : in std_logic;
		Q : out std_logic_vector(3 downto 0);
		OBfree : out std_logic;
		Dval : out std_logic
		);
End OUTPUT_BUFFER;

Architecture structural of OUTPUT_BUFFER is
Component BUFFER_CONTROL is
Port( Load : in std_logic;
		ACK : in std_logic;
		CLK : in std_logic;
		RESET : in std_logic;
		Wreg : out std_logic;
		OBfree : out std_logic;
		Dval : out std_logic
		);
End Component;

Component OUTPUT_REGISTER is
Port( clk : in std_logic;
		EN : in std_logic;
		D : in std_logic_vector(3 downto 0);
		Q : out std_logic_vector(3 downto 0)
		);
End Component;

signal carry_Wreg : std_logic;

Begin

U1 : BUFFER_CONTROL port map( Load => Load, ACK => ACK, RESET => RESET, CLK => CLK, Wreg => carry_Wreg, OBfree => OBfree,
Dval => Dval);

U2 : OUTPUT_REGISTER port map( clk => carry_Wreg, EN => '1', D => D, Q => Q);

End structural;