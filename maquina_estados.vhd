--
-- Autores: Luiz Guilherme Martinho Sampaio Ito     Data: Julho de 2018
--			   Marcelo da Costa Lopes
--
-- Maquina de Estados Finitos para descrição do compressor de vídeo 4x4
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity maquina_estados is
	port(
			Clk		:  in   std_logic;				  -- clock para borda de subida.
			start    :  in   std_logic;   			  -- início da máquina.
			saidaMSS : out   std_logic					  -- saida da maquina de estados.
		);  	
end maquina_estados;

	
architecture hardware of maquina_estados is

type tipo_estado is (estado_ini_1, estado2, estado3, 
							estado4, estado5, estado6, estado7, estado_extra);	-- declaração dos estados.
							
signal estado_atual, proximo_estado: tipo_estado;				-- sinais de estado atual e proximo estado.


begin
--================================================================
--   LÓGICA DE INÍCIO
--================================================================

process(Clk, start, proximo_estado)
	
	begin
		if (start = '1') then
 		        
			estado_atual <= estado_ini_1;
		  
		elsif (Clk = '1' AND Clk'event) then
	      
			estado_atual <= proximo_estado;
	      
		end if;
	
end process;


--==================================================================
--     LÓGICA DE PRÓXIMO ESTADO
--==================================================================

process(estado_atual, start, Clk)

begin
		
	case estado_atual is
		
		when estado_ini_1 =>
			if ( start = '0') then
				proximo_estado  <= estado2;
            else 
				proximo_estado <= estado_ini_1;
			end if;
		
			
		when estado2 =>
			if ( start = '0') then
				proximo_estado  <= estado3;
            else 
				proximo_estado <= estado2;
			end if;
		
		when estado3 =>
			if ( start = '0') then
				proximo_estado  <= estado4;
           else
				proximo_estado <= estado3;
			end if;		
			
		
		when estado4 =>
			if ( start = '0') then
					proximo_estado  <= estado5;
				else 
					proximo_estado <= estado_extra;
			end if;

		when estado_extra =>
			if ( start = '0') then
					proximo_estado  <= estado6;
				else 
					proximo_estado <= estado7;
			end if;
					
		when estado5 =>
			if ( start = '0') then
				proximo_estado  <= estado3;
            else 
				proximo_estado <= estado5;
			end if;
			
		when estado6 =>
			if ( start = '0') then
				proximo_estado  <= estado3;
            else 
				proximo_estado <= estado6;
			end if;
					
		when estado7 =>
			if ( start = '0') then
				proximo_estado  <= estado3;
            else 
				proximo_estado <= estado7;
			end if;
		
								
	end case;

end process;

--=================================================================
-- LÓGICA DE SAÍDA
-- Na lógica de saída se declara todos os sinais de saída que irão controlar 
-- a parte operativa do sistema.
--=================================================================  

process(estado_atual) 
	
 begin
	case estado_atual is
		
			when estado_ini_1 =>
				saidaMSS <= '0';
				 
			when estado2 =>
				saidaMSS <= '0';
			
			when estado3 =>
				saidaMSS <= '0';
		
			when estado5 =>
				saidaMSS <= '0';
		
			when estado6 =>
				saidaMSS <= '0';
				
			when estado7 =>
				saidaMSS <= '0';	
				
			when estado_extra =>
				saidaMSS <= '0';				
			
		   when estado4 =>
				saidaMSS <= '1';
		  		 	
		
	end case;
		
end process;
	
end hardware;
