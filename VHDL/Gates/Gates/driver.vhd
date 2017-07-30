entity VHDL_mux is
PORT (
	a, b, c, d : IN BIT;
	s1, s2 : IN BIT;  
	x : OUT BIT
)	;
end VHDL_mux;

architecture Behavioral of VHDL_mux is
	SIGNAL miou: INTEGER;
begin
	miou <= 	0 when s1 = '0' and s2 = '0' else
					1 when s1 = '0' and s2 = '1' else
					2 when s1 = '1' and s2 = '0' else
					3;
	x <= a after 10 ns  when miou = 0 else
			b after 10 ns when miou = 1 else
			c after 10 ns when miou = 2 else
			d after 10 ns;

end Behavioral;

