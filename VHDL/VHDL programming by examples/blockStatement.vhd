library ieee;
use ieee.std_logic_1164.all;	

package bit32 is
	type tw32 is array (31 downto 0) of std_logic;	
end package bit32;

library ieee;
use ieee.std_logic_1164.all;
use work.bit32.all;

entity cpu is
	port (clk, interrupt: in std_logic;
		addr: out tw32; data : inout tw32);
end entity cpu;

architecture cpu_blk of cpu is
	signal ibus, dbus: tw32;
begin
	alu : block  is
		signal qbus: tw32;
	begin
		--
	end block alu;

	reg8 : block is
		signal zbus: tw32;
	begin
		reg1 : block  is
		signal qbus: tw32;
		begin
			
		end block reg1;
	end block reg8;



end architecture cpu_blk;