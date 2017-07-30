--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DriverGate is
port 
	(x: in std_logic;
	F: out std_logic
);
end DriverGate;

architecture Behavioral of DriverGate is

begin
	process (x)
	begin 
	if (x='1') then 	
		F<='1';
	else 
		F <='0';
	end if;
end process;	
end Behavioral;

architecture Behav2 of DriverGate is
begin 
process(x)
begin 
F<=x;
end process;
end Behav2;