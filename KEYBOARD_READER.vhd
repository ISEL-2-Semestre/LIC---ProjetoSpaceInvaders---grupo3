LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity KEYBOARD_READER is
Port( LIN : in std_logic_vector(3 downto 0);
        ACK : in std_logic;
        CLK : in std_logic;
        RESET : in std_logic;
        COL : out std_logic_vector(2 downto 0);
        Q : out std_logic_vector(3 downto 0);
        Dval : out std_logic
        );
End KEYBOARD_READER;

Architecture structural    of KEYBOARD_READER is
Component KEY_DECODE is
Port( CLK, RESET, Kack : in std_logic;
        LIN : in std_logic_vector(3 downto 0);
        COL : out std_logic_vector (2 downto 0);
        K : out std_logic_vector(3 downto 0);
        Kval : out std_logic);
End Component;

Component RING_BUFFER is
Port( D : in std_logic_vector(3 downto 0);
        DAV : in std_logic;
        CTS : in std_logic;
        RESET : in std_logic;
        CLK : in std_logic;
        Q : out std_logic_vector(3 downto 0);
        Wreg : out std_logic;
        DAC : out std_logic
        );
End Component;

Component OUTPUT_BUFFER is
Port( D : in std_logic_vector(3 downto 0);
        Load : in std_logic;
        ACK : in std_logic;
        RESET : in std_logic;
        CLK : in std_logic;
        Q : out std_logic_vector(3 downto 0);
        OBfree : out std_logic;
        Dval : out std_logic
        );
End Component;

signal carry_DAC: std_logic;
signal carry_K: std_logic_vector(3 downto 0);
signal carry_Kval: std_logic;
signal carry_OBfree: std_logic;
signal carry_Q: std_logic_vector(3 downto 0);
signal carry_Wreg: std_logic;

Begin

U1: KEY_DECODE port map( CLK => CLK, RESET => RESET, Kack => carry_DAC, LIN => LIN, COL => COL, K => carry_K, Kval => carry_Kval);
U2: RING_BUFFER port map( D => carry_K, DAV => carry_Kval, CTS => carry_OBfree, RESET => RESET, CLK => CLK, Q => carry_Q,
 Wreg => carry_Wreg, DAC => carry_DAC);
U3: OUTPUT_BUFFER port map( D => carry_Q, Load => carry_Wreg, ACK => ACK, RESET => RESET, CLK => CLK, Q => Q, 
OBfree => carry_OBfree, Dval => Dval);

End structural;