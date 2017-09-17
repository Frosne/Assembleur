
library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

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
            request : in  std_logic;
            busy_out : out std_logic
        );
    end component; 
    
    --Inputs
    signal position : std_logic_vector(6 downto 0) := (others => '0');
    signal lcd_data_in : std_logic_vector(7 downto 0) := (others => '0');
    signal request : std_logic := '0';

    --Output

    signal displayed_char : std_logic_vector(7 downto 0) := x"42";
    signal busy_out : std_logic;
    
begin
    position <= "0000010";
    
    process (clk)
        variable counter: integer range 0 to 4999999;
    begin
        if rising_edge(clk) and counter < 4999999 then
            counter := counter + 1;
            --request <='0';
        end if;
        if counter < 10000 then
            request <= '0';
        elsif counter < 12000 then
            request <= '1';
        elsif counter < 4999997 then
            request <= '0';
        else
            request <= '1';
        end if;
    end process;

    process (clk)
        variable char_acc : integer range 0 to 5000000;
        variable cc : std_logic := '0';
    begin
        if rising_edge(clk) then
            if (char_acc < 5000000) then
                char_acc := char_acc + 1;
            else
                char_acc := 0;
                cc := not cc;
                if cc = '1' then
                    displayed_char <= x"45";
                else
                    displayed_char <= x"42";
                end if;
            end if;
        end if;
    end process;

    lcd_data_in <= displayed_char;

    lcd: lcd1602Controller port map (
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
end Behavioral;

