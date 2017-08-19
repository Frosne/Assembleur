library ieee;
use ieee.std_logic_1164.all;

entity test is
	generic (rise, fall: time; load : integer);
	port (ina, inb, inc, ind : in std_logic;
		out1, out2 : out std_logic);
end entity test;

architecture test_arch of test is
	component and2 is
		generic (
			rise, fall: time; load : integer);
		port (
			a, b : in std_logic;
			c: out std_logic);
	end component and2;
begin
	u1: and2 generic map (10 ns, 12 ns, 3)
		port map (ina, inb, out1);
	u2: and2 generic map (12 ns, 10 ns, 3)
		port map (inc, ind, out2);	
end architecture test_arch;