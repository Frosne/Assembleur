library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

package bignum is

	type bignum is
		record
			number: std_logic_vector(255 downto 0);
			length: integer;
		end record;		

	function "+" (a: bignum; b: bignum) return bignum;
	function "-" (a: bignum; b: bignum) return bignum;
	function "*" (a: bignum; b: bignum) return bignum;
	function "/" (a: bignum; b: bignum) return bignum;
	function "=" (a: bignum; b: bignum) return boolean;
	function "mod" (a: bignum; b: bignum) return bignum;
	function ">" (a: bignum; b: bignum) return boolean;
	function gcd (a: bignum; b: bignum) return bignum;
	function isZero(a: bignum) return boolean;

end bignum;

package body bignum is

	function "+" (a: bignum; b: bignum) return bignum is
		variable result : unsigned(a.number'range);
		variable r1: bignum;
	begin 
		result := unsigned(a.number) + unsigned(b.number);
		r1 := (number => std_logic_vector(result), length => 0);
		return r1;
	end "+";	
	
	function "-" (a: bignum; b: bignum) return bignum is
		variable result : unsigned(a.number'range);
		variable r1: bignum;
	begin 
		result := unsigned(a.number) - unsigned(b.number);
		r1 := (number => std_logic_vector(result), length => 0);
		return r1;
	end "-";	
	
		function "*" (a: bignum; b: bignum) return bignum is
		variable result : unsigned(511 downto 0);
		variable r1: bignum;
		variable test: std_logic_vector(511 downto 0);
	begin 
		result := unsigned(a.number) * unsigned(b.number);
		r1 := (number => std_logic_vector(result(255 downto 0)), length => 0);
		return r1;
	end "*";	
	
	function "/" (a: bignum; b: bignum) return bignum is
		variable result : unsigned(a.number'range);
		variable r1: bignum;
	begin 
		result := unsigned(a.number) / unsigned(b.number);
		r1 := (number => std_logic_vector(result), length => 0);
		return r1;
	end "/";	
	
	function "mod" (a: bignum; b: bignum) return bignum is
		variable result : unsigned(a.number'range);
		variable r1: bignum;
	begin 
		result := unsigned(a.number) mod unsigned(b.number);
		r1 := (number => std_logic_vector(result), length => 0);
		return r1;
	end "mod";	
	
	function "=" (a: bignum; b: bignum) return boolean is
		variable result :boolean;
	begin 
		result := unsigned(a.number) = unsigned(b.number);
		return result;
	end "=";	
	
	function ">" (a: bignum; b: bignum) return boolean is
		variable result :boolean;
	begin 
		result := unsigned(a.number) > unsigned(b.number);
		return result;
	end ">";	
	
	function isZero(a: bignum) return boolean is
		variable result : boolean:=true;
		variable counter : integer range 0 to 256 := 0;
		variable temp: std_logic;
		variable temp2: boolean;
		begin
			while (counter < 256 and result) loop
				temp := a.number(counter);
				temp2:= (temp='0');
				result := result and temp2;
				counter := counter + 1;
			end loop;
			return result;
		end isZero;
		
	function gcd (a: bignum; b: bignum) return bignum is
		variable result : bignum;
		variable q: bignum;
		variable rm_1: bignum;
		variable rm: bignum;
		variable temp: bignum;
		
	begin 
	if not(a > b) then
		rm_1 := b;
		rm := a;
	else
		rm_1 := a;
		rm := b;
	end if;
		
	while not(isZero (rm)) loop
		q := rm_1 / rm;
		temp := rm;
		rm := rm_1 - (q * rm);
		rm_1 := temp;
	end loop;
		return rm_1;
	end gcd;	
		

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end bignum;
