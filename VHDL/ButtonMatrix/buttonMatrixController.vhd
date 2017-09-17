library IEEE;
use IEEE.std_logic_1164.all;

entity clockDivider is
  generic (period : integer);
  port (
    clk_in : in std_logic;
    clk_out: out std_logic
  );
end entity;

architecture sequential of clockDivider is
  signal tmp : std_logic;
begin
  clk_out <= tmp;

  process (clk_in)
    variable acc : integer range 0 to period := 0;
  begin
    if rising_edge(clk_in) then
      if acc < period then
        acc := acc +1;
      else
        acc := 0;
        tmp <= not tmp;
      end if;
    end if;
  end process;
end architecture;


library IEEE;
use IEEE.std_logic_1164.all;

entity buttonMatrixController is
  port (
    clk : in std_logic;
    columns : in std_logic_vector(3 downto 0);
    lines : out std_logic_vector(3 downto 0);

    res : out std_logic;
    res_col : out integer;--std_logic_vector(1 downto 0);
    res_line : out integer--std_logic_vector(1 downto 0);
  );
  subtype unary4 is std_logic_vector(3 downto 0);
  subtype int4 is integer range 0 to 3;
end entity;


architecture Behavioural of buttonMatrixController is
  function unary_to_int (bits:std_logic_vector(3 downto 0)) return integer -- range 0 to 3
  is
  begin
    for i in 0 to 3 loop
      if bits(i) = '1' then
        return i;
      end if;
    end loop;
    return 0;
  end function unary_to_int;

  function int_to_unary (i:integer range 0 to 3) return std_logic_vector is
  begin
    case i is
      when 0 => return "1000";
      when 1 => return "0100";
      when 2 => return "0010";
      when 3 => return "0001";
    end case;
  end function int_to_unary;

  component clockDivider is
    generic (period : integer);
      port (
        clk_in : in std_logic;
        clk_out: out std_logic
        );
  end component;
begin

  process (clk)
    variable acc : integer range 0 to 4;
    variable found : std_logic := '0';
    variable column : integer range 0 to 3;
    variable line : integer range 0 to 3;
  begin
    if rising_edge(clk) then
      if acc  < 4 then
        lines <= int_to_unary(acc);
        if not (columns = "0000") then
          found := '1';
          line := acc ;
          column := unary_to_int(columns);
        end if;
        acc := acc + 1;
      else
        res <= found;
        res_col <= column;
        res_line <= line;
      end if;
    end if;
  end process;

end architecture;
