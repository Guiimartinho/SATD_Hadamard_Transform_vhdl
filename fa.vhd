-- Projeto: Somador completo (Full Adder)

-- Descrição: Estrutural
-- Nome: Denis Franco

-- Revisão: 1.0 - 01/09/2016


-- Declaração da biblioteca do tipo std_logic



library ieee;

use ieee.std_logic_1164.all;



-- Declaração da entidade


entity fa is
  
port(

       
	X : in std_logic; -- Operando 1
	   
	Y : in std_logic; -- Operando 2
	   
	C : in std_logic; -- Carry-in
	   
	S : out std_logic; -- Soma
	   
	Co : out std_logic -- Carry-out
	  
 );

end 

fa;

-- Descrição da arquitetura interna do Full Adder

architecture struct of fa is

  

signal aux : std_logic; -- Sinal intermediário auxiliar
  


begin


aux <= X XOR Y; 


S <= aux XOR C; -- Geração do std_logic de soma

Co <= (X AND Y) OR (aux AND C); -- Geração do carry-out

end struct;

