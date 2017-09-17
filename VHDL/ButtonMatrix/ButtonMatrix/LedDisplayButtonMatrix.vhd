----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    22:16:03 09/15/2017
-- Design Name:
-- Module Name:    LedDisplayButtonMatrix - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LedDisplayButtonMatrix is
  port (
    clk : in std_logic ;
    columns : out std_logic_vector(3 downto 0);
    lines : in std_logic_vector(3 downto 0);
    leds : out std_logic_vector(7 downto 0);
    ctr_leds : out std_logic_vector(3 downto 0) ;
    led : out std_logic_vector(3 downto 0)
  );
end LedDisplayButtonMatrix;

architecture Behavioral of LedDisplayButtonMatrix is
  component buttonMatrixController is
    port (
      clk : in std_logic;
      columns : out std_logic_vector(3 downto 0);
      lines : in std_logic_vector(3 downto 0);

      res : out std_logic;
      res_col : out integer range 0 to 3;--std_logic_vector(1 downto 0);
      res_line : out integer range 0 to 3--std_logic_vector(1 downto 0);
      );
  end component;
  component clockDivider is
    generic (period : integer);
    port (
      clk_in : in std_logic;
      clk_out: out std_logic
      );
  end component;

  function int4_to_sev_seg(i:integer range 0 to 3) return std_logic_vector is
  begin
    case i is
      when 0 => return "11000000";
      when 1 => return "11111001" ;
      when 2 => return "10100100";
      when 3 => return "10110000";
    end case;
  end function int4_to_sev_seg;

  signal clk_led : std_logic := '0';
  signal buttonPressed : std_logic;
  signal selected_line : integer range 0 to 3;
  signal selected_column : integer range 0 to 3;
  constant period : integer := 100000;
begin

  buttons : buttonMatrixController port map(clk => clk,
                                            columns => columns,
                                            lines => lines,
                                            res => buttonPressed,
                                            res_col => selected_column,
                                            res_line=> selected_line);
  clk_divide_period : clockDivider generic map (period => period) port map(clk_in => clk, clk_out => clk_led);

  led(0) <= buttonPressed;

  process (clk_led)
    variable acc : integer range 0 to 1 := 0;
  begin
    if rising_edge(clk_led) then
      if buttonPressed = '0' then
        leds <= "11111111";
        ctr_leds <= "1111";
      else
        case acc is
          when 0 =>
            ctr_leds <= "0100";
            leds <= int4_to_sev_seg(selected_line);
          when 1 =>
            ctr_leds <= "0001";
            leds <= int4_to_sev_seg(selected_column);
        end case;
        if acc = 1 then acc := 0; else acc := acc + 1; end if;
      end if;
    end if;
  end process;

end Behavioral;

