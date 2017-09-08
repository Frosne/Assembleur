----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:29:21 09/07/2017 
-- Design Name: 
-- Module Name:    lcd1602Driver - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lcd1602Driver is
	port (
	clk : in std_logic;
	
	reset: in std_logic;
	lcd_rs: out std_logic;
	lcd_rw: out std_logic;
	lcd_en: out std_logic;

	lcd_n: out std_logic;
	lcd_p: out std_logic;

	vss: out std_logic;
	vdd: out std_logic;
	vo: out std_logic;

	lcd_data_out: out std_logic_vector (7 downto 0)
	);
end lcd1602Driver;

architecture Behavioral of lcd1602Driver is

    component lcd1602Controller is
     	port (
		 	clk : IN  std_logic;
		    clk_out : INOUT  std_logic;
		    reset : IN  std_logic;
		    lcd_rs : OUT  std_logic;
		    lcd_rw : OUT  std_logic;
		    lcd_en : OUT  std_logic;
		    lcd_n : OUT  std_logic;
		    lcd_p : OUT  std_logic;
		    vss : OUT  std_logic;
		    vdd : OUT  std_logic;
		    vo : OUT  std_logic;
		    position : IN  std_logic_vector(7 downto 0);
		    lcd_data_in : IN  std_logic_vector(7 downto 0);
		    lcd_data_out : OUT  std_logic_vector(7 downto 0);
		    request : INout  std_logic;
			busy_out : out std_logic	
     	);
    end component; 
    
    --Inputs
    signal position : std_logic_vector(7 downto 0) := (others => '0');
    signal lcd_data_in : std_logic_vector(7 downto 0) := (others => '0');
    signal request : std_logic := '0';

 	--Outputs
    signal clk_out : std_logic;
	 signal busy_out: std_logic;
	 
	 signal clk_lcd : std_logic := '0' ;

	--signal request_e : std_logic := '0';

begin

	process (clk)
		variable clk_temp: integer range 0 to 199999;
	begin	
		if rising_edge(CLK) then 
			if (clk_temp < 199999) then 
				clk_temp := clk_temp +1;
				clk_lcd <='0';
			else 
				clk_temp := 0;
				clk_lcd <= '1';
			end if;
		end if;	
	end process;
	
	request <= '1' when (busy_out = '0' and clk_lcd = '1') else 'Z' after 1 sec; --haha
	position <= "10000010";
	lcd_data_in <= x"42";

	lcd: lcd1602Controller port map (
          clk => clk,
          clk_out => clk_out,
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
end Behavioral;

