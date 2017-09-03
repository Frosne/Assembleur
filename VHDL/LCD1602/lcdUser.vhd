LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lcdUser is
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
		vo: out std_logic
	);										
end entity lcdUser;										

architecture lcdUserArch of lcdUser is
	signal position_temp: std_logic_vector(7 downto 0);
	signal lcd_data_in_temp:  std_logic_vector(7 downto 0);
	signal request_temp: std_logic;
	signal letter: std_logic_vector(7 downto 0);
	COMPONENT lcdController is 
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

			position: in std_logic_vector(7 downto 0);

			lcd_data_in: in std_logic_vector(7 downto 0);
			lcd_data_out: out std_logic_vector (7 downto 0);
			request : inout std_logic
	);
end component;
begin
	letter <= x"20";
 dut: lcdController
    PORT MAP(clk => clk, reset => reset, lcd_rs=> lcd_rs, lcd_rw=> lcd_rw, lcd_en=> lcd_en, lcd_n=> lcd_n, 
    		lcd_p=> lcd_p, vss=> vss, vdd=> vdd, vo=> vo, position=> position_temp, 
			lcd_data_in=> lcd_data_in_temp, request=>request_temp);
  
  PROCESS(clk)
    VARIABLE char  :  INTEGER RANGE 0 TO 10 := 0;
  BEGIN
    IF(clk'EVENT AND clk = '1') THEN
    	lcd_data_in_temp <= letter;
    	position_temp<="10000001";--80H 
    	request_temp <= '1';
    END IF;
  END PROCESS;
 	
end architecture lcdUserArch;