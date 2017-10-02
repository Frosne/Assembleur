library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package md5types is
	subtype bytes is std_logic_vector (31 downto 0);
	subtype state is std_logic_vector (127 downto 0);
end package md5types;