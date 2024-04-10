LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity FA is
Port(A, B, Ci : in std_logic;
	Co, S : out std_logic);
End FA;

Architecture structural of FA is
Component HA is
Port(A, B : in std_logic;
	Co, S : out std_logic);
End component;

signal sum : std_logic;
signal carry : std_logic_vector(1 downto 0);

Begin

U1 : Ha port map (A => A, B => B, S => sum, Co => carry(0));

U2 : HA port map (A => sum, B => Ci, S => S, Co => carry(1));

Co <= carry(0) or carry(1);

End structural;