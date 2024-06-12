LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity MEMORY_ADDRESS_CONTROL is
Port( putGet : in std_logic;
        incPut : in std_logic;
        incGet : in std_logic;
        RESET : in std_logic;
		  CLK : in std_logic;
        A : out std_logic_vector(2 downto 0);
        full : out std_logic;
        empty : out std_logic
        );
End MEMORY_ADDRESS_CONTROL;

Architecture structure of MEMORY_ADDRESS_CONTROL is
Component COUNTER_UP is
Port( dataIn : in std_logic_vector(3 downto 0);
        RESET : in std_logic;
        PL : in std_logic;
        CE : in std_logic;
        CLK : in std_logic;
        Q : out std_logic_vector(3 downto 0)
        );
End Component;

Component MUX_4 is
Port(A, B : IN STD_LOGIC_VECTOR(3 Downto 0);
        S : In STD_LOGIC;
        Y : Out STD_LOGIC_VECTOR(3 Downto 0));
End Component;

Component FULL_EMPTY is
Port( CD, CU, CLK, RESET : in std_logic;
		empty, full : out std_logic
        );
End Component;

signal carry_REGput, carry_REGget, carry_A : std_logic_vector(3 downto 0);

Begin 

U1 : COUNTER_UP port map ( dataIn => "0000", RESET => RESET, PL => RESET, CE => incPut, CLK => CLK, Q => carry_REGput);

U2 : COUNTER_UP port map ( dataIn => "0000", RESET => RESET, PL => RESET, CE => incGet, CLK => CLK, Q => carry_REGget);

U3 : FULL_EMPTY port map( CU => incPut, CD => incGet, RESET => RESET, CLK => CLK, empty => empty, full => full);

U4 : MUX_4 port map (A => carry_REGget, B => carry_REGput, S => putGet, Y => carry_A);

A <= carry_A(2 downto 0);

End Architecture;

