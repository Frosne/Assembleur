entity reg is
	port (
		a, clock: in bit;
		d: out bit
	);
end entity reg;

architecture test of reg is
	signal b,c: bit;
begin
	b<= NOT (a);
	c<= NOT (clock and b);
	d<=c and b;
end architecture test;