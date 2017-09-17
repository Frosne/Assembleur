----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    22:06:33 09/17/2017
-- Design Name:
-- Module Name:    KeyPadDebug - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity KeyPadDebug is
  port(
    clk : in std_logic;
    lines : in std_logic_vector(3 downto 0);
    columns : out std_logic_vector(3 downto 0);
    segments : out std_logic_vector(7 downto 0);
    position : out std_logic_vector(3 downto 0);
    led : out std_logic_vector(3 downto 0)
);
end KeyPadDebug;

architecture Behavioral of KeyPadDebug is
  function int4_to_sev_seg(i:integer range 0 to 3) return std_logic_vector is
  begin
    case i is
      when 0 => return "11000000";
      when 1 => return "11111001" ;
      when 2 => return "10100100";
      when 3 => return "10110000";
    end case;
  end function int4_to_sev_seg;

  function int4_to_unary (i:integer range 0 to 3) return std_logic_vector is
  begin
    case i is
      when 0 => return "0111";
      when 1 => return "1011";
      when 2 => return "1101";
      when 3 => return "1110";
    end case;
  end function int4_to_unary;

  component clockDivider is
    generic (period : integer);
    port (
      clk_in : in std_logic;
      clk_out: out std_logic
      );
  end component;

  -- signal sev_seg_clk : std_logic;
  signal column_switch_clk : std_logic;
  signal column : integer range 0 to 3;

  constant freq : integer := 50000000;
  -- constant display_refresh_period : integer := 100000;
  constant column_switch_period : integer := 2 * freq;
begin
  position <= "0001";
  segments <= int4_to_sev_seg(column);
  columns <= int4_to_unary(column);
  led <= lines;

  -- sev_seg_divider : clockDivider
  --   generic map (period => display_refresh_period)
  --   port map (clk_in => clk, clk_out => sev_seg_clk);

  column_switch_divider : clockDivider
    generic map (period => column_switch_period)
    port map (clk_in => clk, clk_out => column_switch_clk);

  process (column_switch_clk)
  begin
    if rising_edge(column_switch_clk) then
      if column < 3 then
        column <= column + 1;
      else
        column <= 0;
      end if;
    end if;
  end process;


end Behavioral;

