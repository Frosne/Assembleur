----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:09:04 08/01/2017 
-- Design Name: 
-- Module Name:    mux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity andport is 
Port (a : in STD_LOGIC;
			b: in STD_LOGIC;
			o: out std_logic);
end andport;

architecture and_arch of andport is
begin process (a, b)
begin
	o<=a and b;
end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity notport is 
Port (a : in STD_LOGIC;
			o: out std_logic);
end notport;

architecture not_arch of notport is
begin process (a)
begin
	o<=not a;
end process;
end;

library IEEE;
use IEEE.std_logic_1164.all;

entity or4 is 
	port (a, b, c, d: in std_logic; o: out std_logic);
end or4;

architecture or4_arch of or4 is
begin 
process (a,b,c,d)
begin 
o <= a or b or c or d;
end process;
end or4_arch;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           d : in  STD_LOGIC;
           i : in  STD_LOGIC_VECTOR (1 downto 0);
           o : out  STD_LOGIC);
end mux;

architecture Behavioral of mux is
component andport
	port (a: in std_logic; b: in std_logic; o: out std_logic);
end component;
component notport
	port (a: in std_logic;  o: out std_logic);
end component;	
component or4 
	port (a,b,c,d: in std_logic; o: out std_logic);
end component;

signal ab,nota, notb, z1, z2, z3, z4, z6, z7, z8, z5: std_logic;

begin
	
	u0: notport port map(a=> i(0),  o=> nota); 
	u1: notport port map (a=> i(1), o=> notb);
	u2: andport port map (a=> nota, b => notb, o => z1);
	
	u3: notport port map (a => i(0), o => nota);
	u4: andport port map (a=> nota, b => i(1), o=> z2);
	
	u5: notport port map (a => i(1), o => notb);
	u6: andport port map (a=> i(0), b=> notb, o=> z3);
	
	u7: andport port map (a=> i(0), b => i(1), o => z4);

	u8: andport port map (a=> a, b=> z1, o => z5);

	u9: andport port map (a=> b, b=>z2, o=>z7);
	
	u10: andport port map (a=> c, b=> z3, o=> z6);
	
	u11: andport port map (a=>d, b=> z4, o=> z8);
	
	u12: or4 port map (a=> z5, b=> z6, c=> z7, d=> z8, o=> o);

	
end Behavioral;

