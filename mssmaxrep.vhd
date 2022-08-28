library ieee;
use ieee.std_logic_1164.all;

entity mssmaxrep is
	port(
		resetn,clk: in std_logic;
		AB,AB2,finalr: in std_logic;
		resetNcnt,resetcnt,resetcdcnt,resetreg: out std_logic;
		encnt,enNcnt,encntcd,enR,enN: out std_logic;
		est: out std_logic_vector(3 downto 0));
end mssmaxrep;

architecture solve of mssmaxrep is
	-- Signals,Constants,Variables,Components
	type estado is (Ta,Tb,Tc,Td,Te,Tf,Tg,Th);
	signal y: estado;
	begin
	--Process #1: Next state decoder and state memory
	process(resetn,clk)
	--Sequential programming
		begin
			if resetn = '0' then y<= Ta;
			elsif (clk'event and clk = '1') then
				case y is
					when Ta => y<= Tb;					  
					when Tb => y<= Tc;
					when Tc => 
					        if AB='0' and finalr='0' then y<= Td;
							  elsif AB='0' and finalr='1' then y<= Tf;
							  else y<= Te;end if;
					when Td => y<= Tc;
					when Te => 
					        if finalr='0' then y<= Td;
	                    else y<= Tf;end if;
					when Tf => 
					        if AB2='0' then y<= Th;
	                    else y<= Tg;end if;
					when Tg => y<= Th;
					when Th => y<= Tb;
				end case;
			end if;
	end process;
	--Process #2: Output decoder
	process(y)-- mealy ->(y,d,n)
	--Sequential programming
		begin
			resetNcnt<='0';resetcnt<='0';resetcdcnt<='0';resetreg<='0';enNcnt<='0';encnt<='0';encntcd<='0';enR<='0';enN<='0';est<="0000";
			case y is
				when Ta => resetreg<='1';resetcdcnt<='1';est<="0001";
				when Tb => resetNcnt<='1';resetcnt<='1';est<="0010";
				when Tc => est<="0011";
				when Td => encnt<='1';est<="0100";
				when Te => enNcnt<='1';est<="0101"; 
				when Tf => est<="0110";
				when Tg => enR<='1';enN<='1';est<="0111";
				when Th => encntcd<='1';est<="1000";
			end case;
	end process;
	--Process #n... 
end solve;