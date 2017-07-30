----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:12:05 07/30/2017 
-- Design Name: 
-- Module Name:    logical_and - Behavioral 
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

entity logical_and is
port (input1: in std_logic; 
input2: in std_logic;
output: out std_logic);
end logical_and;

architecture Behavioral of logical_and is
begin
process(input1, input2)
begin
	output <= input1 and input2;
end process;
end Behavioral;

