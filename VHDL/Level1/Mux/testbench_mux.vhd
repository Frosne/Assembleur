--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:48:53 08/01/2017
-- Design Name:   
-- Module Name:   C:/Users/Natalia/Documents/GitHub/Assembleur/VHDL/Level1/Mux/testbench_mux.vhd
-- Project Name:  Mux
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux
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
 
ENTITY testbench_mux IS
END testbench_mux;
 
ARCHITECTURE behavior OF testbench_mux IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         c : IN  std_logic;
         d : IN  std_logic;
         i : IN  std_logic_vector(1 downto 0);
         o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal c : std_logic := '0';
   signal d : std_logic := '0';
   signal i : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal o : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux PORT MAP (
          a => a,
          b => b,
          c => c,
          d => d,
          i => i,
          o => o
        );

   -- Clock process definitions
   clock_process :process
   begin
		i <= "00";
		wait for clock_period/2;
		a <='1';
		wait for clock_period/2;
		a <='0';
		b <='1';
		wait for clock_period/2;
		b <='0';
		c <='1';
		wait for clock_period/2;
		c <='0';
		d <='1';
		wait for clock_period/2;
		i <= "01";
			d<='0';
			a <='1';
			wait for clock_period/2;
			a <='0';
			b <='1';
			wait for clock_period/2;
			b <='0';
			c <='1';
			wait for clock_period/2;
			c <='0';
			d <='1';
		wait for clock_period/2;
		i <= "10";
			d<='0';
			a <='1';
			wait for clock_period/2;
			a <='0';
			b <='1';
			wait for clock_period/2;
			b <='0';
			c <='1';
			wait for clock_period/2;
			c <='0';
			d <='1';
			wait for clock_period/2;
		i <= "11";
			d<='0';
			a <='1';
			wait for clock_period/2;
			a <='0';
			b <='1';
			wait for clock_period/2;
			b <='0';
			c <='1';
			wait for clock_period/2;
			c <='0';
			d <='1';
		wait for clock_period/2;
			d <='0';
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
