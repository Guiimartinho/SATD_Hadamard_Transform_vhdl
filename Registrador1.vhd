--
--
-- Autor: Luiz Guilherme Martinho Sampaio Ito
--
--
--	Registrador 6 bits para o projeto da caideira de
---------------------------------------------------
----------------	Registrador1    -----------------
---------------------------------------------------
--
-- Sistemas Digitais I
--
-- Data: Julho 2018
--
library ieee;
use ieee.std_logic_1164.all;

entity Registrador1 is
		port(
			Load1		:	in	std_logic;
			Reg1in	:	in	std_logic_vector(5 downto 0);
			Clk		:	in	std_logic;
			Clr		:	in std_logic;
			Reg1out	:	out std_logic_vector(5 downto 0)
			);
end Registrador1; 

architecture Registrador1 of Registrador1 is
begin
		process(Clk, Clr)
		begin	
			if Clr = '1' then
				Reg1out <= "000000";
			elsif Clk'event and Clk = '1' then
				if Load1 = '1' then
					Reg1out	<=	Reg1in;
			   end if;
			end if;			
		end process;
end Registrador1;		
				
