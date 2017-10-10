library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package lcdTypes is
	type dataBusVector is array (0 to 63) of std_logic_vector(7 downto 0);
end package lcdTypes;