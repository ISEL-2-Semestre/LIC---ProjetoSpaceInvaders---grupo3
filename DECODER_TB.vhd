LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DECODER_TB is
end DECODER_TB;

architecture arc_DECODER_TB of DECODER_TB is

component DECODER
Port( S1, S0 : in std_logic;
		Q0, Q1, Q2, Q3 : out std_logic);
End component;

signal S1_TB, S0_TB, Q0_TB, Q1_TB, Q2_TB, Q3_TB : std_logic;

begin 

U1 : DECODER port map(S1 => S1_TB, S0 => S0_TB, Q0 => Q0_TB, Q1 => Q1_TB, Q2 => Q2_TB, Q3 => Q3_TB);

process
begin

S1_TB <= '0';
S0_TB <= '0';

wait for 10ns;

S0_TB <= '1';

wait for 10ns;

S0_TB <= '0';
S1_TB <= '1';

wait for 10ns;

S0_TB <= '1';

wait for 10ns;

wait;

end process;

end arc_DECODER_TB;