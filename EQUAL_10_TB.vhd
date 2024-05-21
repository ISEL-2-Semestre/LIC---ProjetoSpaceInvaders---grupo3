LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity EQUAL_10_TB is
end EQUAL_10_TB;

Architecture arc_EQUAL_10_TB of EQUAL_10_TB is

Component EQUAL_10 is
Port(	D : in std_logic_vector( 3 downto 0);
		Y : out std_logic
		);
end component;

signal D_TB : std_logic_vector(3 downto 0);
signal Y_TB : std_logic;

begin

UUT: EQUAL_10
		port map(D => D_TB,
					Y => Y_TB
					);

stimulus: process 
begin

	D_TB <= "0000";

	wait for 20 ns;
	
	D_TB <= "0001";

	wait for 20 ns;
	
	D_TB <= "0010";

	wait for 20 ns;
	
	D_TB <= "0011";

	wait for 20 ns;
	
	D_TB <= "0100";

	wait for 20 ns;
	
	D_TB <= "0101";

	wait for 20 ns;
	
	D_TB <= "0110";

	wait for 20 ns;
	
	D_TB <= "0111";

	wait for 20 ns;
	
	D_TB <= "1000";

	wait for 20 ns;
	
	D_TB <= "1001";

	wait for 20 ns;
	
	D_TB <= "1010";

	wait for 20 ns;
	
	D_TB <= "1011";

	wait for 20 ns;
	
	D_TB <= "1100";

	wait for 20 ns;
	
	D_TB <= "1101";

	wait for 20 ns;
	
	D_TB <= "1110";

	wait for 20 ns;
	
	D_TB <= "1111";
	
	wait for 20 ns;

	wait;
	
	end process;
	
	end architecture;