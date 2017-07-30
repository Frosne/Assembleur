
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity logical_or is
port (in1: in std_logic;
in2: in std_logic;
output: out std_logic);
end logical_or;

architecture Behavioral of logical_or is
	begin
		process(in1, in2)
		begin
			output <=in1 or in2;
		end process;
	end Behavioral;

