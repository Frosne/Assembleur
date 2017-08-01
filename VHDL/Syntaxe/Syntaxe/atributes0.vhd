LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY d_flop IS
PORT (d,clk,clr, set : IN std_logic;
	q : OUT std_logic);
END d_flop;

ARCHITECTURE behavior OF d_flop IS -- fonctionnement d'une bascule D
	CONSTANT clrit: std_logic := '0';
	CONSTANT setit: std_logic := '1';
BEGIN
	PROCESS (clk, clr, set) -- liste de sensibilite
	BEGIN
		IF (clk='1') AND (clk'EVENT) THEN -- true for rising edge
			IF (clr = '1') THEN -- if clear then 
				q <= clrit; -- returns 0
			ELSIF (set = '1') THEN -- if set then 
				q <= setit; -- set 
			ELSE
				q <= d; -- previous value
			END IF;
		END IF;
	END PROCESS;
END behavior;