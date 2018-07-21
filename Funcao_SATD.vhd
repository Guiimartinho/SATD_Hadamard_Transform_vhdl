----------------------------------------------------------------
----------------------------------------------------------------
-- 				Universidade Federal de Pelotas					  --
--																				  --
--						Engenharia Eletrônica							  --
--																				  --
--						 Sistemas Digitais I								  --
--																				  --
-- Projeto função SATD (Sum of Absolute Transform Difference) --
-- -(Soma das Diferenças Transfromadas Absolutas), utilizando --
-- a Transformada de Hadamard na forma de circuito sequencial --
-- 																			  --
-- Autores: Luiz Guilherme Martinho Sampaio Ito					  --
--				Marcelo da Costa Lopes									  --
--																				  --	
--																				  --
-- Data: Julho 2018 														  --
--																				  --
----------------------------------------------------------------
----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Funcao_SATD is

 port (
		Y11, Y12, Y21, Y22 : in std_logic_vector (3 downto 0)
		); -- entradas do bloco
		
		
end entity;
architecture comportamento of Funcao_SATD is

component Reg_inicial -- Registrador de Start.
		port (Regin0, Regin1, Regin2, Regin3, 		: in std_logic_vector;
				Regout0, Regout1, Regout2, Regout3  : out std_logic;
				Load_ini										: in std_logic);	

component contador -- Contador do valor absoluto.
		port (X0 , X1, X2, X3 		  : in std_logic_vector ( 5 downto 0 );
				ABS0, ABS1, ABS2, ABS3 : out std_logic_vector ( 5 downto 0 )
				);
end component

component MUX 	
		port (M0, M1 , M2, M3 : in std_logic_vector (5 downto 0);
				Saida_mux 		 : out std_logic_vector (5 downto 0 );
				Sel_mux 			 : in std_logic_vector (1 downto 0)
				);
end component

component Registrador1
		port (R1 : in std_logic_vector ( 5 downto 0);
				Q1 : out std_logic_vector (5 downto 0);
				Load1 : in std_logic
				);				
				
end component

component somador 
		port (SomaA, SomaB 	: in std_logic_vector (5 downto 0);
				carryin 			: in std_logic;
				carryout 		: out std_logic;
				saidasoma 		: out std_logic_vector (5 downto 0)
				);
end component				

component Registrador2
		port (R2 	: in std_logic_vector ( 5 downto 0);
				Q2 	: out std_logic_vector (5 downto 0);
				Load2 : in std_logic
				);		
end component	

signal
 Re0,Re1,Re2,Re3 : std_logic_vector (4 downto 0);  -- signal de saida do registrador.
 A, B, C, D      : std_logic_vector (4 downto 0);  -- signal de entrada da primeira operação.
 W0, W1, W2, W3  : std_logic_vector (5 downto 0);  -- signal de entrada da segunda operação.
 I0, I1, I2, I3  : std_logic_vector (5 downto 0); 	-- signal de entrada do contador.
 J0, J1, J2, J3  : std_logic_vector (5 downto 0);	-- signal de entrada do mux.
 K               : std_logic_vector (5 downto 0); 	-- signal de entrada serial do registrador 1.
 O					  : std_logic_vector (5 downto 0); 	-- signal de entrada do somador.
 P					  : std_logic_vector (5 downto 0); 	-- signal de entrada do registrador 2.
 Z					  : std_logic_vector (5 downto 0);  -- signal de realimentaçao do somador.
 Load_ini		  : std_logic;								-- signal para MSS do resgistrador inicial.
 Load1			  : std_logic;								-- signal para MSS do resgistrador 1.
 Load2			  : std_logic; 							-- signal para MSS do resgistrador 2.
 
 
begin
	-- Equações das entradas das metrizes HT*HT^-1
	Re0 + Re2 = A;
	Re0 - Re2 = C;
	Re2 + Re4 = B;
	Re2 - Re4 = D;
	
	A + B = W0;
	A - B = W2;
	C + D = W1;
	C - D = W3;
	
	-- Ligaçao Start.
	Start : reg_inicial port map (Reg_entrada => Y11 , Reg_saida => Re0, Clk => Clk
	Start : reg_inicial port map (Reg_entrada => Y12 , Reg_saida => Re1, Clk => Clk
	Start : reg_inicial port map (Reg_entrada => Y21 , Reg_saida => Re3, Clk => Clk
	Start : reg_inicial port map (Reg_entrada => Y22 , Reg_saida => Re4, Clk => CLk


	-- Ligação contador absoluto com mux 4x1.
	ContadorABS : contador port map ( X0 => I0,	ABS0 => J0, Clk => Clk);
	ContadorABS : contador port map ( X1 => I1,	ABS1 => J1, Clk => Clk);
	ContadorABS : contador port map ( X2 => I2,	ABS2 => J2, Clk => Clk);
	ContadorABS : contador port map ( X3 => I3,	ABS3 => J4, Clk => Clk);
	
	--Ligação mux 4x1 com registrador 1.	
	Mux4x1 : Mux port map ( M0 => J0,	Saida_mux => K, Clk => Clk); 
   Mux4x1 : Mux port map ( M1 => J1,	Saida_mux => K, Clk => Clk); 
	Mux4x1 : Mux port map ( M2 => J2,	Saida_mux => K, Clk => Clk); 
	Mux4x1 : Mux port map ( M3 => J3,	Saida_mux => K, Clk => Clk); 

	-- Ligação do registrador1 com somador.
	Reg1 : Registrador1 port map ( R1 => K,	Q1 => O, Clk => Clk); 
	
	
	-- Ligaçao do somador com registrador 2.
	Soma : somador port map ( SomaA => O, saidasoma => P ); 
	Soma : Registrador1 port map ( SomaB => O, saidasoma => P ); 

	-- Ligaçao registrador realimentaçao
	Reg2 : Registrador2 port map (R2 => P, Q2 => Z , Clk => Clk);
	
	


