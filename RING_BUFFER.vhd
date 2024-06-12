LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity RING_BUFFER is
Port( D : in std_logic_vector(3 downto 0);
DAV : in std_logic;
CTS : in std_logic;
RESET : in std_logic;
CLK : in std_logic;
Q : out std_logic_vector(3 downto 0);
Wreg : out std_logic;
DAC : out std_logic
);
End RING_BUFFER;

Architecture structural of RING_BUFFER is
Component RING_BUFFER_CONTROL is
Port( DAV : in std_logic;
CTS : in std_logic;
full : in std_logic;
empty : in std_logic;
RESET : in std_logic;
CLK: in std_logic;
Wr : out std_logic;
selPG : out std_logic;
incPut : out std_logic;
incGet : out std_logic;
Wreg : out std_logic;
DAC : out std_logic
);
End Component;

Component MEMORY_ADDRESS_CONTROL is
Port( putGet : in std_logic;
incPut : in std_logic;
incGet : in std_logic;
RESET : in std_logic;
CLK: in std_logic;
A : out std_logic_vector(2 downto 0);
full : out std_logic;
empty : out std_logic
);
End Component;

Component RAM is
generic(
ADDRESS_WIDTH : natural := 3;
DATA_WIDTH : natural := 4
);
port(
address : in std_logic_vector(ADDRESS_WIDTH - 1 downto 0);
wr: in std_logic;
din: in std_logic_vector(DATA_WIDTH - 1 downto 0);
dout: out std_logic_vector(DATA_WIDTH - 1 downto 0)
);
End Component;

signal carry_Wr : std_logic;
signal carry_selPG : std_logic;
signal carry_incPut : std_logic;
signal carry_incGet : std_logic;
signal carry_full : std_logic;
signal carry_empty : std_logic;
signal carry_A : std_logic_vector(2 downto 0);

Begin

U1: RING_BUFFER_CONTROL port map( DAV => DAV, CTS => CTS, full => carry_full, empty => carry_empty,
RESET => RESET, CLK => CLK, Wr => carry_Wr, selPG => carry_selPG, incPut => carry_incPut, incGet => carry_incGet,
Wreg => Wreg, DAC => DAC);

U2: MEMORY_ADDRESS_CONTROL port map( putGet => carry_selPG, incPut => carry_incPut, incGet => carry_incGet, RESET => RESET,
CLK => CLK, A => carry_A, full => carry_full, empty => carry_empty);

U3: RAM port map( address => carry_A, wr => carry_Wr, din => D, dout => Q);

End structural;
