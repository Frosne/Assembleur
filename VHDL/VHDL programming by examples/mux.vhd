Library IEEE;
USE IEEE.std_logic_1164.ALL;

entity mux4 is
  port (
	i0, i1, i2, i3, a,b : in std_logic;
	q: out std_logic_1164
  ) ;
end mux4; -- mux4

architecture mux4 of mux4 is
signal sel: integer;
begin
	with sel select
	q <= i0 after 10 ns when 0,
		i1 after 10 ns when 1,
		i2 after 10 ns when 2,
		i3 after 10 ns when 3,
		'X' after 10 ns when others;

sel <= 0 when a = '0' and b = '0' else
		1 when a = '0' and b = '1' else
		2 when a = '1' and b = '0' else
		3 when a = '1' and b = '1' else
		4;
 
end architecture mux4;
