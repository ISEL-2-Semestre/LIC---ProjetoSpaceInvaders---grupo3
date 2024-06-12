LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity RING_BUFFER_CONTROL is
Port(	DAV	: in std_logic;
		full	: in std_logic;
		empty	: in std_logic;
		CTS	: in std_logic;
		CLK	: in std_logic;
		RESET : in std_logic;
		incPut: out std_logic;
		incGet: out std_logic;
		Wr		: out std_logic;
		selPG : out std_logic;
		Wreg 	: out std_logic;
		DAC	: out std_logic);
end RING_BUFFER_CONTROL;

architecture behavioral of RING_BUFFER_CONTROL is

type STATE_TYPE is (STATE_1, STATE_2, STATE_3, STATE_4, STATE_5, STATE_6, STATE_7);

signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

begin
CURRENT_STATE<= STATE_1 when RESET='1' else NEXT_STATE when rising_edge(CLK);

GENERATENEXTSTATE:
process (CURRENT_STATE, DAV, full, empty, CTS)
	begin
	case CURRENT_STATE is
		when STATE_1 => if (DAV='1' and full='0') then 
			               NEXT_STATE<= STATE_2;
							 elsif ((DAV='1' and full='1' and CTS='0') or (DAV='0' and CTS='0') or (DAV='0' and CTS='1' and empty='1')) then
								NEXT_STATE <= STATE_1;
							 elsif ((DAV='1' and full='1' and CTS='1') or (DAV='0' and CTS='1' and empty='0')) then
								NEXT_STATE <= STATE_6;
							 else
								NEXT_STATE <= STATE_1;
							 end if;
							 
		when STATE_2 => 	NEXT_STATE <= STATE_3;
		
		when STATE_3 => 	NEXT_STATE<= STATE_4;
							
		when STATE_4 => 	NEXT_STATE <= STATE_5;
		
		when STATE_5 => if (DAV='0') then
								NEXT_STATE <= STATE_1;
							else 
								NEXT_STATE <= STATE_5;
							end if;
								
		when STATE_6 => if (CTS='0') then
								NEXT_STATE <= STATE_7;
							else
								NEXT_STATE <= STATE_6;
							end if;
								
		when STATE_7 =>	NEXT_STATE <= STATE_1;
		
		end case;
end process;    
Wr<= '1' 			when (CURRENT_STATE = STATE_3)
					else '0';
Wreg<= '1' 			when (CURRENT_STATE = STATE_6)
					else '0';
incPut<= '1' 		when (CURRENT_STATE = STATE_4)
					else '0';					
incGet<= '1' 		when (CURRENT_STATE = STATE_7)
					else '0';
selPG<= '1' 		when ((CURRENT_STATE = STATE_2) or (CURRENT_STATE = STATE_3))
					else '0';
DAC<= '1' 		when (CURRENT_STATE = STATE_5)
					else '0';						
end behavioral;