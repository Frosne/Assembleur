-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Driver is 
port (x: in std_logic; 
		F: out std_logic
);
end Driver;

architecture beh1 of Driver is
begin 
	process (x)
	begin
	if (x = '1') then 
		F<='1';
	else
		F<='0';
	end if;
end process;
end beh1;

architecture beh2 of Driver is 
begin 
		process (x) 
		begin 
		F<=x;
		end process;
end beh2; 		