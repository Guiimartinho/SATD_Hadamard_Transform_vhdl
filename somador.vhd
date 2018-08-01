-- Projeto: Somador n bits (Ripple-carry)

-- Descrição: Estrutural parametrizada

-- Nome: Denis Franco

-- Revisão: 2.0 - 22/09/2016




-- Declaração da biblioteca do tipo std_logic
library 

ieee;


use ieee.std_logic_1164.all;



-- Declaração da entidade


entity somador is
  -- generic (n : integer); 

-- Declaração de uma variável genérica, ou parâmetro
  

port(

       
	SomaA : in std_logic_vector(5 downto 0); -- Operando 1
	   
	SomaB : in std_logic_vector(5 downto 0); -- Operando 2
	   
	carryin : in std_logic; -- Carry-in
	   
	saidasoma : out std_logic_vector(5 downto 0);-- Soma
	   
	carryout : out std_logic -- Carry-out
	   
);

end somador;



-- Descrição da estrutura interna do somador de 4 bits


architecture struct of somador is



-- Declaração do componente Full Adder


component fa

  
port(

       
	X : in std_logic; -- Operando 1
	   
	Y : in std_logic; -- Operando 2
	   
	C : in std_logic; -- Carry-in
	   
	S : out std_logic; -- Soma
	   
	Co : out std_logic -- Carry-out
	  
 );

end component;

  

signal 

	C : std_logic_vector(5 downto 0); -- Sinal de carry interno
  

begin



-- Conexão do carry externo com o carry interno


	C(0) <= carryin;

-- Geração automática da cadeia de blocos do somador de n bits 

	Ripple: for k in 0 to 4 generate
  
	FAk : fa port map (SomaA(k), SomaB(k), C(k), saidasoma(k), C(k+1));

end generate;

-- Conexão do carry interno com o carry externo

	carryout <= C(5);


end struct;

