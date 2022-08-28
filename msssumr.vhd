library ieee;
use ieee.std_logic_1164.all;

entity msssumr is
	port(
		resetn,clk: in std_logic;
		finalr: in std_logic;
		resetcnt, resetreg: out std_logic;
		encnt,enreg,ensumr: out std_logic;
		est: out std_logic_vector(2 downto 0));
end msssumr;

architecture solve of msssumr is
	-- Signals,Constants,Variables,Components
	type estado is (Ta,Tb,Tc,Td);
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
					when Tb => 
							  if finalr='0' then y<= Tc;
	                    else y<= Td;end if;
					when Tc => y<= Tb;
					when Td => y<= Td;
				end case;
			end if;
	end process;
	--Process #2: Output decoder
	process(y)-- mealy ->(y,d,n)
	--Sequential programming
		begin
			resetcnt<='0';enreg<='0';encnt<='0';ensumr<='0';resetreg<='0';est<="000";
			case y is
				when Ta => resetcnt<='1';resetreg<='1'; est<="001";
				when Tb => enreg<='1';ensumr<='1';est<="010";
				when Tc => encnt<='1';est<="011";
				when Td => est<="100";
			end case;
	end process;
	--Process #n... 
end solve;