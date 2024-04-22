library ieee;
use ieee.std_logic_1164.all;

entity PARITY_CHECK is 
    port(
    data, clk, Reset,  init: in std_logic;
    err: out std_logic
    );
end PARITY_CHECK;

architecture PARITY_CHECK_Arch of PARITYCHECK is

component CounterUp is
    port(
    dataIn : in std_logic_vector(3 downto 0);
    PL : in std_logic;
    CE: in std_logic;
    CLK : in std_logic;
    RESET : in std_logic;
    Q : out std_logic_vector(3 downto 0)
    );
end component;

signal sum: std_logic_vector(3 downto 0);

begin

Cont: CounterUp port map (dataIn => "0000" , PL => '0', CE => data, CLK => Clk , RESET => Reset, Q => sum);

err <= sum(0);

end PARITY_CHECK_Arch;
