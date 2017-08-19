library ieee;
use ieee.std_logic_1164.all;

entity buf is
	port (
		a: in std_logic;
		b: out std_logic
	);
end entity buf;

architecture buf of buf is
begin
	b<= a after 20 ns;
end  buf;