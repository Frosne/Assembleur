library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity lcd1602Controller is
	port (

		clk : in std_logic;
		clk_out: inout std_logic;
		
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
		request : inout std_logic;
		busy_out : out std_logic
		
	);
end entity lcd1602Controller;

architecture beh of lcd1602Controller is
	type state is 
		(main, clearDisplay, function_set, display_on_off,
			entry_mode_set, write_cgram, set_ddram, write_data);
	signal currentState : state;
	--signal clk1: std_logic;
	--signal clk_out: std_logic;
	signal lcd_clk: std_logic;
	--signal temp: std_logic := '0';
	signal inited : std_logic := '0';
	signal busy : std_logic := '0';
	
	begin
		lcd_en <= clk_out;
		lcd_rw <= '0';
		lcd_n <= '0';
		lcd_p <= '1';
		vss<= '0';
		vdd<= '1';
		vo <= '1';

		
		process	(clk)
			variable n1: integer range 0 to 2;
			variable temp : std_logic := '0';
			begin
				if rising_edge(clk) then 
					if n1 < 2 then 
						n1:= n1 + 1;
					else 
						n1:=0;
						temp := not temp;
						clk_out <= temp;
						lcd_clk <= temp;
					end if;
				end if;		
		end process;
		
		--lcd_clk <= clk_out;
	
	request <= '0' when busy = '1' else 'Z';
	busy_out <= busy;

	process (request, currentState, reset, lcd_data_in, position, lcd_clk, inited, busy)
		begin 
			if reset = '0' then 
				currentState <= main;
				lcd_rs <= '0';
			elsif busy = '0' and request = '1' then
				lcd_rs <= '0';
				if busy = '1' then 
					currentState<= currentState;
				elsif inited = '0' then
				   busy <= '1';
					currentState <= clearDisplay;
				else
					busy <= '1';
					currentState <= write_cgram;	
				end if;
			elsif busy = '1' and rising_edge(LCD_Clk) then
				case currentState is 
					when main => 
						lcd_rs <= '0';
						if busy = '1' then 
							currentState<= currentState;
						elsif inited = '0'
							then currentState <= clearDisplay;
						else 
							currentState <= write_cgram;	
						end if;	
					when clearDisplay =>
						lcd_rs <= '0'; 
						busy <= '1';
						lcd_data_out <= "00000001";
						currentState <= function_set;
					when function_set => -- function set
						lcd_rs <= '0';
						-- 001 DL N F * *
						-- DL - data length 0 = 4-bit interface, 1 = 8-bit interface;
						-- N - number of display line N - 0 = 1/8 or 1/11 duty (1 line), 1 = 1/16 duty (2 lines);
						-- F - and character font -F - 0 = 5×8 dots, 1 = 5×10 dots;
						-- F - 0/1 - didnot find a difference
						lcd_data_out <= "00111000";
						currentState <= display_on_off;
					when display_on_off => 
						lcd_rs <= '0';
						lcd_data_out <= "00001100";
						-- 00001 D C B 
						-- D - on off all display
						-- C - cursor on off
						-- B - blinking on off
						currentState <= entry_mode_set;
					when entry_mode_set => 
						lcd_rs <= '0';
						lcd_data_out <= "00000110";
						-- 00000 1 i/D S
						-- I/D - 0 = decrement cursor position,
						-- 1 = increment cursor position; 
						-- for some reason moving back
						-- S - 0 = no display shift, 1 = display shift;
						currentState <= write_cgram;
					when write_cgram => 
						-- Write data to CGRAM or DDRAM.
						busy<= '1';
						lcd_rs <= '1';
						lcd_data_out <= lcd_data_in;	
						currentState <= set_ddram;
						-- &mcar[data_in]
					when set_ddram =>
						lcd_rs <= '0';
 						lcd_data_out <= position;
						currentState <= write_data;		
						busy<= '1';			
					when write_data =>
						lcd_rs <= '0'; 
						lcd_data_out <= "00000000";
						currentState <= write_cgram;
						busy <= '0';
						--request <= '0' when wri else 'Z';
					when others => null;	
				end case;
			end if;
		end process;			
end architecture beh;