--
--
-- Autor: Luiz Guilherme Martinho Sampaio Ito
--
--
--	Registrador 4 de 6 bits para o projeto da caideira de
--             Sistemas Digitais I
--
---------------------------------------------------------
---------------	Registrador Inicial   -----------------
---------------------------------------------------------
--
-- Data: Julho 2018
--
library ieee;
use ieee.std_logic_1164.all;

entity Reg_inicial is
		port(
			Load_ini										:	in	std_logic;
			Regin0, Regin1, Regin2, Regin3		:	in	std_logic_vector(3 downto 0);
			Clk											:	in	std_logic;
			Clr											:	in std_logic;
			Regout0, Regout1, Regout2, Regout3	:	out std_logic_vector(3 downto 0)
			);
end Reg_inicial; 

architecture Reg_inicial of Reg_inicial is
begin
		process(Clk, Clr)
		begin	
			if Clr = '1' then
				Regout0 <= "0000";
			elsif Clr = '1' then
				Regout1 <= "0000";
			elsif Clr = '1' then
				Regout2 <= "0000";
			elsif Clr = '1' then
				Regout3 <= "0000";
			elsif Clk'event and Clk = '1' then
				if Load_ini = '1' then
					Regout0 <=	Regin0;
				elsif Load_ini = '1' then
					Regout1 <= Regin1;
				elsif Load_ini = '1' then
					Regout2 <= Regin2;
				elsif Load_ini = '1' then
					Regout3 <=	Regin3;
			   end if;
			end if;			
		end process;
end Reg_inicial;		





