---------------------------------------------------------------------------
-- Bianca Silveira 

-- Maquina de Estados 

-- Exemplo de uma FSM de 3 estados com 1 sinal de controle (load)
-----------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-- FSM para SATD1_8x8 --

ENTITY FSM_exemplo IS
    PORT (
          clk_in  : in std_logic; 			-- sinal de clock
          start   : in std_logic;			-- in�cio do sistema
          load    : out std_logic			-- sa�da da m�quina de estados que servem de controle par o sistema operativo (ex: load)
          );
END FSM_exemplo;

architecture rtl of FSM_exemplo is

type tipo_estado is (estado0,  estado1,  estado2);		-- Declara��o de quantos estados possui a m�quina.
						   
signal estado_atual, proximo_estado: tipo_estado; 		-- Sinais de estado atual e pr�ximo estado
    
  
BEGIN

--================================================================
--   L�GICA DE IN�CIO
--================================================================
PROCESS(clk_in, start, proximo_estado)
	
	BEGIN
		IF (start = '1') THEN
 		        
			estado_atual <= estado0;
		  
		ELSIF (clk_in = '1' AND clk_in'EVENT) THEN
	      
			estado_atual <= proximo_estado;
	      
		END IF;
	
END PROCESS;
--===================================================================     
          


--==================================================================
--     L�GICA DE PR�XIMO ESTADO

-- Nesta parte do projeto � onde se declara os estado seguintes.
--==================================================================  
PROCESS(estado_atual, start)

BEGIN
		
	CASE estado_atual IS
		
		when estado0 =>
			if ( start = '0') then
				proximo_estado  <= estado1;
            else 
				proximo_estado <= estado0;
			end if;
			
		when estado1 =>
			if ( start = '0') then
				proximo_estado  <= estado2;
            else 
				proximo_estado <= estado1;
			end if;

		when estado2 =>
			if ( start = '0') then
				proximo_estado  <= estado0;
            else 
				proximo_estado <= estado2;
			end if;
	
	END CASE;

END PROCESS;
--=================================================================


--=================================================================
-- L�GICA DE SA�DA
-- Na l�gica de sa�da se declara todos os sinais de sa�da que ir�o controlar 
-- a parte operativa do sistema. Neste exemplo s� possui um sinal 
-- de controle "load". 
--=================================================================  
PROCESS(estado_atual) 
	
BEGIN
	CASE estado_atual IS
		
		when estado0 =>
			load <= '0';
				 
		when estado1 =>
			load <= '1';
			
		when estado2 =>
			load <= '0';

	END CASE;
		
END PROCESS;
	
END rtl;
