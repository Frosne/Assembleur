library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.md5types.all;

entity CompressionFunction is
	port(
		clk: in std_logic;
		counter: integer range 0 to 63;
		b: in bytes;
		c: in bytes;
		d: in bytes;
		result: out bytes
	);
end CompressionFunction;

architecture Behavioral of CompressionFunction is
	
	function StateAnd (a: bytes; b: bytes) return bytes is 
	variable tempBuffer: bytes;
		begin 
		tempBuffer := a and b; 
		return tempBuffer;
	end function StateAnd;	
	
	function StateNand (a: bytes; b: bytes) return bytes is 
	variable tempBuffer: bytes;
		begin 
		tempBuffer := not a and b;
		return tempBuffer;
	end function StateNand;	
	
	function StateXor (a: bytes; b: bytes) return bytes is 
	variable tempBuffer: bytes;
		begin 
		tempBuffer := a xor b;
		return tempBuffer;
	end function StateXor;	
	
	function StateOr (a: bytes; b: bytes) return bytes is 
	variable tempBuffer: bytes;
		begin 
		tempBuffer := a or b; 
		return tempBuffer;
	end function StateOr;
		
	function CompressionFunctionP1 (b: bytes; c: bytes; d: bytes) return bytes is
	variable tempBuffer: bytes;
	variable tempBuffer2: bytes;
	variable tempBuffer3: bytes;
		begin 
			tempBuffer:= StateAnd (b, c);
			tempBuffer2:= StateNand (b, d);
			tempBuffer3:= StateOr (tempBuffer, tempBuffer2);
			return tempBuffer3;
	end function CompressionFunctionP1;
	
	
	function CompressionFunctionP2 (b: bytes; c: bytes; d: bytes) return bytes is
	variable tempBuffer: bytes;
	variable tempBuffer2: bytes;
	variable tempBuffer3: bytes;
		begin
			tempBuffer:= StateAnd (b,c);
			tempBuffer2:= StateNand(d, c);
			tempBuffer3:= StateOr (tempBuffer, tempBuffer2);
			return tempBuffer3;
	end function CompressionFunctionP2;

	function CompressionFunctionP3 (b: bytes; c: bytes; d: bytes) return bytes is
	variable tempBuffer: bytes;
	variable tempBuffer2: bytes;
		begin
			tempBuffer:= StateXor (b,c);
			tempBuffer2:= StateXor (tempBuffer, d);
			return tempBuffer2;
	end function CompressionFunctionP3;

	function CompressionFunctionP4 (b: bytes; c: bytes; d: bytes) return bytes is
	variable tempBuffer: bytes;
	variable tempBuffer2: bytes;
		begin
			tempBuffer := StateNand (d, b);
			tempBuffer2 := StateXor (c, tempBuffer);
			return tempBuffer2;
	end function CompressionFunctionP4;
	
	begin 
		main: process (clk, counter, b, c, d)
		begin 
			if (rising_edge (clk)) then
				case counter is 
					when 0 to 15 =>
						result <= CompressionFunctionP1(b,c,d);
					when 16 to 31 =>
						result <= CompressionFunctionP2(b,c,d);
					when 32 to 47 => 
						result <= CompressionFunctionP3(b,c,d);
					when 48 to 63 =>
						result <= CompressionFunctionP4(b,c,d);
				end case;	
			end if;		
		end process main;	

	
end Behavioral;

