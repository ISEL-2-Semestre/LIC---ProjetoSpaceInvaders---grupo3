LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DECODER is
Port( S1, S0 : in std_logic;
      Q0, Q1, Q2, Q3 : out std_logic
      );
end DECODER;

architecture logicFunction of DECODER is

Begin

Q0 <= not S0 and not S1;
Q1 <= S0 and not S1;
Q2 <= not S0 and S1;
Q3 <= S0 and S1;

end logicFunction;