LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity MUX_4_2 is
Port( A, B, C, D : IN STD_LOGIC;
		S0, S1 : In STD_LOGIC;
		Y : Out STD_LOGIC);
End MUX_4_2;

architecture logicFunction of MUX_4_2 is

Begin

Y <= (A and not S0 and not S1) or (B and S0 and not S1) or (C and not S0 and S1) or (D and S0 and S1);

END LogicFunction;