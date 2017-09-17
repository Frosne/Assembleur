library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lcd1602Controller is
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

        position: in std_logic_vector(6 downto 0);

        lcd_data_in: in std_logic_vector(7 downto 0);
        lcd_data_out: out std_logic_vector (7 downto 0);
        request : in std_logic;
        busy_out: out std_logic
    );
end entity lcd1602Controller;


architecture beh of lcd1602Controller is
    type state is 
        (waiting, clearDisplay, function_set, display_on_off,
            entry_mode_set, set_position, write_char, display);
    signal currentState : state;
	 signal rising_edge_request : std_logic;
	 signal busy: std_logic:='0'; 
	 signal inited: std_logic := '0';
	 signal clk_lcd: std_logic;
	
    
	 begin
        lcd_rw <= '0';
        lcd_n <= '0';
        lcd_p <= '1';
        vss<= '0';
        vdd<= '1';
        vo <= '1';
		  
	process(clk)
		variable counter:integer range 0 to 19999;
		begin 
		if rising_edge(clk) then
			if counter<19999 then
				counter:=counter+1;
			else 
				counter:=0;
				clk_lcd<=not clk_lcd;
			end if;
		end if;
	end process;	  
		  
		  
	process(clk, request)
	variable request_status : std_logic := '0';
	variable request_status_before: std_logic := '0';
		begin
			request_status_before := request_status;
			request_status := request;
			if (request_status_before = '0' and request_status ='1') then
				rising_edge_request <= '1';
			else 
				rising_edge_request <= '0';
			end if;
			
	end process;
	
	process (clk_lcd, reset, request, currentState)
		begin
			if reset = '1' then --?
				inited <='0';
				currentState <= waiting;
				lcd_rs <='0';
				
			elsif rising_edge_request = '1' and busy = '0' then
				busy <= '1';
				if inited = '0' then 
					currentState <= clearDisplay;
				else
					currentState <= set_position;
				end if;
				
			elsif rising_edge(clk_lcd) then				
				currentState <= currentState ;
				lcd_rs <='0';
				
			case currentState is
					when clearDisplay => 			
						lcd_data_out <= "00000001";
						currentState <= function_set;
					when function_set => 
						lcd_data_out <= "00111000";
						currentState <= display_on_off;
					when display_on_off =>
						lcd_data_out <= "00001100";
						currentState <= entry_mode_set;
					when entry_mode_set =>
						lcd_data_out <= "00000110";
						currentState <= set_position;
						inited <= '1';
					when set_position =>
						lcd_data_out <= '1' & position;
						currentState <= write_char;
					when write_char =>
						lcd_rs <= '1';
						lcd_data_out <= lcd_data_in;
						currentState <= display;
					when display => 
						lcd_data_out <= "00000000";
						currentState <= waiting;
						busy <= '0';
					when others =>
						currentState <= waiting;
				end case;
			end if;	
			
	end process;	
           
end architecture beh;




