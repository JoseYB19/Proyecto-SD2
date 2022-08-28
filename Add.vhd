
--Library
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--Entity
entity Add is
	generic ( n: integer :=10);--<------- nbits
	port(
		X: in std_logic_vector(n downto 0);
		y: in std_logic_vector(n-7 downto 0);
		S: out std_logic_vector(n downto 0));
end Add;

--Architecture
architecture solve of Add is
	-- Signals,Constants,Variables,Components
	begin
		s<=(x)+("0000000"&y);--Without the sign bit
		--s<='0'&(x+y);--with sign bit
end solve;
