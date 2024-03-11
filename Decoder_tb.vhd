LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity Decoder_tb is
End Decoder_tb;

architecture arc_Decode_tb of Decoder_tb is

Component DECODER
Port( S1, S0 : in std_logic;
      Q0, Q1, Q2, Q3 : out std_logic
      );
end Component;

signal S1_TB, S0_TB, Q0_TB, Q1_TB, Q2_TB: std_logic;

begin
U1: DECODER port map(S1 => S1_TB, S0 => S0_TB, Q0 => Q0_TB, Q1 => Q1_TB, Q2 => Q2_TB);

process 
begin

S1_TB <= '0';
S0_TB <= '0';

wait for 10ns;

S1_TB <= '1';
S0_TB <= '0';

wait for 10ns;

S1_TB <= '0';
S0_TB <= '1';

wait for 10ns;

S1_TB <= '1';
S0_TB <= '1';

wait for 10ns;
wait;

end process;

end arc_Decode_tb;