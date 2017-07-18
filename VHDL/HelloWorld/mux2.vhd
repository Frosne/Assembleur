architecture netlist of VHDL_mux is
	COMPONENT andgate
		PORT (a,b,c : IN bit; d: out bit);
	end component;
	component orgate
			port (a, b, c, d : in bit; x : out bit);
	end component;
	component inverter 
		port (in1: in bit; x : out bit);
	end component;
	
SIGNAL s1_inv, s2_inv, andtemp1, andtemp2 , andtemp3, andtemp4 : BIT;
	
BEGIN
		U1 : inverter port map (s1, s1_inv);
		u2: inverter port map(s2, s2_inv);
		u3: andgate port map(a, s2_inv, 
			s1_inv, andtemp1);
		u4: andgate port map(b, s2_inv, 	
			s1, andtemp2);
		u5: andgate port map(c, s2, s1_inv, 
			andtemp3);
		u6: andgate port map(d, s2, s1,
			andtemp4);	
		u7: orgate port map(b => andtemp1, a => andtemp2, c => andtemp3, d => andtemp4, x=> x);	
		u8: orgate port map(andtemp1, andtemp2, andtemp3, andtemp4, x);	
		
		
end netlist;

