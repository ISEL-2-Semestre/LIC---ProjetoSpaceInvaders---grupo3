LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity LCD_D_CONTROL is
Port(	Dval	: in std_logic;
		CLK	: in std_logic;
		RESET : in std_logic;
		Wrl	: out std_logic;
		done 	: out std_logic);
end LCD_D_CONTROL;

architecture behavioral of LCD_D_CONTROL is

type STATE_TYPE is (STATE_1, STATE_2, STATE_3);

signal CURRENT_STATE, NEXT_STATE : STATE_TYPE;

begin
CURRENT_STATE<= STATE_1 when RESET='1' else NEXT_STATE when rising_edge(CLK);

GENERATENEXTSTATE:
process (CURRENT_STATE,Dval)
	begin
	case CURRENT_STATE is
		when STATE_1 => if (Dval='1') then 
			                NEXT_STATE<= STATE_2;
							 else 
								 NEXT_STATE <= STATE_1;
							 end if;
		when STATE_2 =>	 NEXT_STATE<= STATE_3;
							 
		when STATE_3 => if(Dval='1') then 
								NEXT_STATE<= STATE_3;
							 else 
								NEXT_STATE<= STATE_1;
							end if;
		end case;
end process;    
Wrl<= '1' 		when ((CURRENT_STATE = STATE_2 or CURRENT_STATE = STATE_3))
					else '0';
done<= '1' 		when ((CURRENT_STATE = STATE_3))
					else '0';
end behavioral;
