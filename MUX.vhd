LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY MUX IS
	PORT(
		 opcion2: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 opcion3: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 opcion1: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 valor:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sel1: IN STD_LOGIC;
		 sel2: IN STD_LOGIC;
		 sel3: IN STD_LOGIC;
		 SAL: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END MUX;

architecture solve of MUX is
signal y: std_logic_vector(7 downto 0); 
	begin 
	process(sel1,sel2,sel3,valor) is
	begin
		if (sel1='1' and valor="00000001") then
			y<= opcion1;
		elsif (sel2='1' and valor="00000010") then
			y<="0000"&opcion2;
		elsif (sel3='1' and valor="00000011") then
			y<="0"&opcion3;
		else 
			y<="11111111";
		end if;
		SAL<=y;
	end process;
end solve;