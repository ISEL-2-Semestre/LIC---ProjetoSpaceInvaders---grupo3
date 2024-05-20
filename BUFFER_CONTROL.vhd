LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity BUFFER_CONTROL is
Port( Load : in std_logic;
		ACK : in std_logic;
		CLK : in std_logic;
		RESET : in std_logic;
		Wreg : out std_logic;
		OBfree : out std_logic;
		Dval : out std_logic
		);
end BUFFER_CONTROL;

architecture behavioral of BUFFER_CONTROL is

type STATE_TYPE is (STATE_1, STATE_2, STATE_3, STATE_4);

signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

begin
CURRENT_STATE<= STATE_1 when RESET='1' else NEXT_STATE when rising_edge(CLK);

GENERATENEXTSTATE:
process (CURRENT_STATE,Load, ACK)
    begin
    case CURRENT_STATE is
        when STATE_1 => if (Load='1') then 
                            NEXT_STATE<= STATE_2;
                             else 
                                 NEXT_STATE <= STATE_1;
                             end if;
                             
        when STATE_2 =>     NEXT_STATE <= STATE_3;
                             
        when STATE_3 => if(ACK='1') then 
                                NEXT_STATE<= STATE_4;
                             else 
                                NEXT_STATE<= STATE_3;
                            end if;
                            
        when STATE_4 => if (ACK='1') then
                                NEXT_STATE <= STATE_1;
                             else
                                NEXT_STATE <= STATE_4;
                             end if;
        
        end case;
end process;    
OBfree<= '1'         when ((CURRENT_STATE = STATE_1))
                    else '0';
Wreg<= '1'             when ((CURRENT_STATE = STATE_2))
                    else '0';
Dval<= '1'             when ((CURRENT_STATE = STATE_3))
                    else '0';                    
end behavioral;