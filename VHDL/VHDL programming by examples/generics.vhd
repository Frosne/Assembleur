entity and2 is
  generic (rise, fall: time; load: integer);
  port (
	a, b : in bit;
	c: out bit) ;
end entity ; -- and2

architecture load_dependent of and2 is
	signal internal : bit;
begin
	internal <= a and b;
	c<= internal after(rise + (load * 2 ns)) when internal = '1' 
	else
		internal after (fall + (load * 3 ns));
end architecture load_dependent;

