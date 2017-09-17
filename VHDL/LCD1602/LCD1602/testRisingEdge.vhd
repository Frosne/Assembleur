--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:42:17 09/17/2017
-- Design Name:   
-- Module Name:   C:/Users/Natalia/Documents/GitHub/Assembleur/VHDL/LCD1602/LCD1602/testRisingEdge.vhd
-- Project Name:  LCD1602
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lcd1602Controller
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
 
ENTITY testRisingEdge IS
END testRisingEdge;
 
ARCHITECTURE behavior OF testRisingEdge IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lcd1602Controller
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         lcd_rs : OUT  std_logic;
         lcd_rw : OUT  std_logic;
         lcd_en : OUT  std_logic;
         lcd_n : OUT  std_logic;
         lcd_p : OUT  std_logic;
         vss : OUT  std_logic;
         vdd : OUT  std_logic;
         vo : OUT  std_logic;
         position : IN  std_logic_vector(6 downto 0);
         lcd_data_in : IN  std_logic_vector(7 downto 0);
         lcd_data_out : OUT  std_logic_vector(7 downto 0);
         request : IN  std_logic;
         busy_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal position : std_logic_vector(6 downto 0) := (others => '0');
   signal lcd_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal request : std_logic := '0';

 	--Outputs
   signal lcd_rs : std_logic;
   signal lcd_rw : std_logic;
   signal lcd_en : std_logic;
   signal lcd_n : std_logic;
   signal lcd_p : std_logic;
   signal vss : std_logic;
   signal vdd : std_logic;
   signal vo : std_logic;
   signal lcd_data_out : std_logic_vector(7 downto 0);
   signal busy_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lcd1602Controller PORT MAP (
          clk => clk,
          reset => reset,
          lcd_rs => lcd_rs,
          lcd_rw => lcd_rw,
          lcd_en => lcd_en,
          lcd_n => lcd_n,
          lcd_p => lcd_p,
          vss => vss,
          vdd => vdd,
          vo => vo,
          position => position,
          lcd_data_in => lcd_data_in,
          lcd_data_out => lcd_data_out,
          request => request,
          busy_out => busy_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		request <= '1';
		  wait for 100 ns;	
		request <= '0';
		 wait for 100 ns;	
		request <= '1';
			  wait for 100 ns;	
		request <= '0';
		 wait for 100 ns;	
		request <= '1';
			  wait for 100 ns;	
		request <= '0';
		 wait for 100 ns;	
		request <= '1';
			  wait for 100 ns;	
		request <= '0';
		 wait for 100 ns;	
		request <= '1';
			  wait for 100 ns;	
		request <= '0';
		 wait for 100 ns;	
		request <= '1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
