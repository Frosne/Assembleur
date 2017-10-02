library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.md5types.all;

entity MessageBlock is
	port(
		clk: in std_logic;
		counter: in integer range 0 to 63;
		message: in std_logic_vector (511 downto 0);
		messageBlock: out bytes
	
	);
	
end MessageBlock;

architecture Behavioral of MessageBlock is

begin
	main: process(clk)
		variable tempCounter: integer range 0 to 15;
		variable blockStart: integer range 0 to 511;
		begin
			case counter is
				when 0 to 15 =>
					tempCounter := counter;
				when 16 to 31 =>
					tempCounter := (counter * 5  + 1 ) rem 16;
				when 32 to 47 =>
					tempCounter := (counter * 3 + 5) rem 16;
				when 48 to 63 => 
					tempCounter := (counter * 7) rem 16;
			end case;
			blockStart := (tempCounter + 1) * 32 -1; 
			messageBlock <= message(blockStart downto blockStart - 31);	
		end process main;	
	
end Behavioral;

