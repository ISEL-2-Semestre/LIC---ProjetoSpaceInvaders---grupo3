LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity HA is
Port(A, B : in std_logic;
	Co, S : out std_logic);
End HA;

ARCHITECTURE logicFunction of Ha is
Begin

Co <= (A and B);
S <= (A xor B);

End logicFunction;