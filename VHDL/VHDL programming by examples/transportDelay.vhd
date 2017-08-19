library ieee;
use ieee.std_logic_1164.all;

entity delay_line is
	port(a: in std_logic;
		b: out std_logic);
end entity delay_line;

architecture delay_line of delay_line is

begin
	b<= transport a after 20 ns;
end  delay_line;