--
--
-- Autor: Luiz Guilherme Martinho Sampaio Ito
--
--
--	Registrador 6 bits para o projeto da caideira de
--             Sistemas Digitais I
--
---------------------------------------------------
----------------	Registrador 2   -----------------
---------------------------------------------------
--
-- Data: Julho 2018
--
library ieee;
use ieee.std_logic_1164.all;

entity Registrador2 is
		port(
			Load2		:	in	std_logic;
			Reg2in	:	in	std_logic_vector(5 downto 0);
			Clk		:	in	std_logic;
			Clr		:	in std_logic;
			Reg2out	:	out std_logic_vector(5 downto 0)
			);
end Registrador2; 

architecture Registrador2 of Registrador2 is
begin
		process(Clk, Clr)
		begin	
			if Clr = '1' then
				Reg2out <= "000000";
			elsif Clk'event and Clk = '1' then
				if Load2 = '1' then
					Reg2out	<=	Reg2in;
			   end if;
			end if;			
		end process;
end Registrador2;		
				
