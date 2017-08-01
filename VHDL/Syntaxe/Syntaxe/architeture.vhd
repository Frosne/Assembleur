library ieee;
use ieee.std_logic_1164.all;
entity fulladd is
	port (x,y,cin: in bit;
	sum, cout: out bit);
end fulladd;

architecture behaviour of fulladd is
begin 
		sum <= x xor y xor cin;
		cout <= (x and y) or (x and cin) or (y and cin);
end behaviour;