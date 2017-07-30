--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:40:18 07/30/2017
-- Design Name:   
-- Module Name:   C:/Users/Natalia/Documents/GitHub/Assembleur/VHDL/Gates/Gates/testbenc_or.vhd
-- Project Name:  Gates
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: logical_or
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbenc_or IS
END testbenc_or;
 
ARCHITECTURE behavior OF testbenc_or IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT logical_or
    PORT(
         in1 : IN  std_logic;
         in2 : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in1 : std_logic := '0';
   signal in2 : std_logic := '0';

 	--Outputs
   signal output : std_logic;
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: logical_or PORT MAP (
          in1 => in1,
          in2 => in2,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		in1 <= '0';
		in2 <='0';
		wait for clk_period/2;
		in2 <='1';
		wait for clk_period/2;
		in1 <= '1';
		in2 <='0';
		wait for clk_period/2;
		in2 <='1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
