 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KEYSCAN is
Port(    Kscan : in std_logic;
        Clk : in std_logic;
        Reset : in std_logic;
        lin0, lin1, lin2, lin3 : in std_logic;
        Dout : out std_logic_vector(2 downto 0);
        Kpress : out std_logic;
        K : out std_logic_vector(3 downto 0)
        );
end KEYSCAN;

Architecture structural of KEYSCAN is
Component COUNTER_UP is
Port( dataIn : in std_logic_vector(3 downto 0);
        RESET : in std_logic;
        PL : in std_logic;
        CE : in std_logic;
        CLK : in std_logic;
        Q : out std_logic_vector(3 downto 0));
End Component;

Component DECODER is
Port(    S1, S0 : in std_logic;
        Q0, Q1, Q2, Q3 : out std_logic
        );
end Component;

Component MUX_4_2 is
Port( A, B, C, D : IN STD_LOGIC;
        S0, S1 : In STD_LOGIC;
        Y : Out STD_LOGIC);
End Component;

signal carry_Q0 : std_logic;
signal carry_Q1 : std_logic;
signal carry_Q2 : std_logic;
signal carry_Q3 : std_logic;
signal neg_Dout0 : std_logic;
signal neg_Dout1 : std_logic;
signal neg_Dout2 : std_logic;
signal carry_Kpress : std_logic;
signal carry_Q : std_logic_vector(3 downto 0);


Begin

U1 : COUNTER_UP port map(dataIn => "0000", RESET => Reset, PL => '0', CE => Kscan, CLK => Clk, Q(3) => carry_Q3, Q(2) => carry_Q2, Q(1) => carry_Q1, Q(0) => carry_Q0);
U2 : DECODER port map(S1 => carry_Q3, S0 => carry_Q2, Q0 => neg_Dout0, Q1 => neg_Dout1, Q2 => neg_Dout2);
U3 : MUX_4_2 port map(A => lin0, B => lin1, C => lin2, D => lin3, S1 => carry_Q1, S0 => carry_Q0, Y => carry_Kpress);

Dout(0) <= not neg_Dout0;
Dout(1) <= not neg_Dout1;
Dout(2) <= not neg_Dout2;
Kpress <= not carry_Kpress;
carry_Q(0) <= carry_Q0;
carry_Q(1) <= carry_Q1;
carry_Q(2) <= carry_Q2;
carry_Q(3) <= carry_Q3;
K <= carry_Q;

end structural;