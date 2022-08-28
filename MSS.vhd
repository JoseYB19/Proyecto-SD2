LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY MSS IS
	PORT(clock,reset,start, fin:IN STD_LOGIC;
		  tecla_igual_1,tecla_igual_2,tecla_igual_3: IN STD_LOGIC;
		 f1,f2,f3 : OUT STD_LOGIC;
		 EST: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END MSS;

ARCHITECTURE sol OF MSS IS
Type estado is (Ta,Tb,Tc,Td,Te,Tf,Tg);
SIGNAL y:estado;
BEGIN
	PROCESS(clock,reset)
	BEGIN
		if reset='0' then y<=Ta;
  		elsif (clock'event and clock='1') then
			case y is
				when Ta=> 	if start='1' then y<=Tb;
								else y<=Ta;
								end if;
				when Tb=>	if start='1' then y<=Tb;
								else y<=Tc;
								end if;
				when Tc=>	if tecla_igual_1='1' then y<=Td;
								elsif tecla_igual_2='1' then y<=Te;
								elsif tecla_igual_3='1' then y<=Tf;
								else y<=Tc; end if;
				when Td=>	if fin='1' then y<=Tg;
								else y<=Td;
								end if;
				when Te=>	if fin='1' then y<=Tg;
								else y<=Te;
								end if;
				when Tf=>	if fin='1' then y<=Tg;
								else y<=Tf;
								end if;
				when Tg=>	y<=Tc;
			end case;
		end if;
	END PROCESS;
	
PROCESS(y)
	BEGIN
		f1<='0';f2<='0';f3<='0';EST<="000";
			case y is
				when Ta=>	EST<="001";
				when Tb=>	EST<="010";
				when Tc=>	EST<="011";
				when Td=>	EST<="100";f1<='1';
				when Te=>	EST<="101";f2<='1';
				when Tf=>	EST<="110";f3<='1';
				when Tg=>	EST<="111";
			end case;
	END PROCESS;
END sol;