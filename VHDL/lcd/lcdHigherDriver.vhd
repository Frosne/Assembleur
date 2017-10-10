
library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.lcdTypes.all;


entity lcdHigherDriver1 is
	port(

	clk: in std_logic;
	databus: in dataBusVector (63 downto 0);
	length: integer;

	reset: in std_logic;
    lcd_rs: out std_logic;
    lcd_rw: out std_logic;
    lcd_en: out std_logic;

    lcd_n: out std_logic;
    lcd_p: out std_logic;

    vss: out std_logic;
    vdd: out std_logic;
    vo: out std_logic;

    lcd_data_out: out std_logic_vector (7 downto 0);
    led : out std_logic_vector(3 downto 0)

	);
end entity lcdHigherDriver1;

architecture Beh of lcdH is
	component lcdDriver is
 

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

	    lcd_data_out: out std_logic_vector (7 downto 0);
	    led : out std_logic_vector(3 downto 0)

    );
	end component lcdDriver;
begin
	
end architecture Beh;