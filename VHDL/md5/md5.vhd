
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package md5types is
	subtype bytes is std_logic_vector (31 downto 0);
end package md5types;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.md5types.all;

entity CompressionFunction is
	port(
		counter: integer range 0 to 63;
		b: bytes;
		c: bytes;
		d: bytes;
		result: bytes
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
	
end Behavioral;

