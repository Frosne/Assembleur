LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity nor2 is
	port (a,b: in std_logic;
	z: out std_logic);
end nor2;

ARCHITECTURE behaviour of nor2 is
begin 
	dly0: process(a,b)
		begin
			z<= a nor b after 1 ns; -- time of propogation is 10 seconds
		end process dly0;
end behaviour; 		
		