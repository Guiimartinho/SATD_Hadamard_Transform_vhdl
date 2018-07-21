-- 
--	Universiade Federal de Pelotas
--
--	Engenharia Eletrônica
--
-- Autores: Luiz Guilherme Martinho Sampaio Ito 
--				Marcelo da Costa Lopes
--
-- Data: Julho 2017
--
--	Mux 4/1 de 6 bits para o projeto de Sistemas Digitais I

library ieee;
use ieee.std_logic_1164.all;
 
entity MUX is
 port( 
     M0, M1, M2, M3 			  : in std_logic_vector (5 downto 0);		-- entradas do mux de 6 bits.
     SelMux0,SelMux1	 		  : in std_logic_vector (1 downto 0);		-- entradas de seleção do mux.
     Saida_mux		 		  	  : out std_logic_vector(5 downto 0)		-- saida de 6 bits.
		);
end MUX;
 
architecture comportamento of MUX is
begin
	process (M0,M1,M2,M3,SelMux0,SelMux1) is
		begin
		if (SelMux0 ="0" and SelMux1 = "0") then
				Saida_mux <= M0;
			elsif (SelMux0 ="1" and SelMux1 = "0") then
				Saida_mux <= M1;
			elsif (SelMux0 ="0" and SelMux1 = "1") then
				Saida_mux <= M2;
			elsif (SelMux0 ="1" and SelMux1 = "1") then
				Saida_mux <= M3;
		end if;
 
	end process;
end comportamento;