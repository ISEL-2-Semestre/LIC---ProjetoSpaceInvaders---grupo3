LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_4_2_TB is
end MUX_4_2_TB;

architecture arc_MUX_4_2_TB of MUX_4_2_TB is

component MUX_4_2
Port( A, B, C, D : IN STD_LOGIC;
		S0, S1 : In STD_LOGIC;
		Y : Out STD_LOGIC);
End component;

signal A_TB, B_TB, C_TB, D_TB, S0_TB, S1_TB, Y_TB : std_logic;

begin 

U1 : MUX_4_2 port map(A => A_TB, B => B_TB, C => C_TB, D => D_TB, S0 => S0_TB, S1 => S1_TB, Y => Y_TB);

process
begin

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '0';
S0_TB <= '0';
S1_TB <= '0';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '0';
S0_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '0';
S0_TB <= '0';
S1_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '0';
S0_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '0';
D_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '0';
C_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait for 10ns;

A_TB <= '0';
B_TB <= '1';

wait for 10ns;

A_TB <= '1';

wait;

end process;

end arc_MUX_4_2_TB;