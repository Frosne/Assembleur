-- entation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY and_test_bench IS
END and_test_bench;
 
ARCHITECTURE behavior OF and_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT logical_and
    PORT(
         input1 : IN  std_logic;
         input2 : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input1 : std_logic := '0';
   signal input2 : std_logic := '0';

 	--Outputs
   signal output : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: logical_and PORT MAP (
          input1 => input1,
          input2 => input2,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		input1 <= '0';
		input2 <='0';
		wait for clk_period/2;
		input2 <='1';
		wait for clk_period/2;
		input1 <= '1';
		input2 <='0';
		wait for clk_period/2;
		input2 <='1';
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
