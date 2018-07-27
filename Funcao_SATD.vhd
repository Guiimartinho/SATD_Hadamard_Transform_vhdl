library ieee;
use ieee.std_logic_1164.all;

entity Funcao_SATD is

 port (
		Y11, Y12, Y21, Y22 : in std_logic_vector (3 downto 0);
		SaidaFinal         : out std_logic_vector(5 downto 0)  
		); -- entradas do bloco
		
		
end entity;
architecture comportamento of Funcao_SATD is

 --component maqui -- Maquina de estados
--port( reset, clk	: in	std_logic;
	--		x		: 	in std_logic;
		--	y		:  in std_logic;
			--q0		: out std_logic;
			--q1		: out std_logic 
		--); 

component Reg_inicial -- Registrador de Start.
		port (Regin0, Regin1, Regin2, Regin3, 		: in std_logic_vector (4 downto 0);
				Regout0, Regout1, Regout2, Regout3  : out std_logic_vector (4 downto 0);
				Load_ini										: in std_logic;	
				Clk                                 : in std_logic
				);
end component

component contador -- Contador do valor absoluto.
		port (
				ABSS 						  : out std_logic_vector ( 5 downto 0 );
				creset 					  : in std_logic;	
				cload 					  : in std_logic;	
				X 					        : in std_logic_vector ( 5 downto 0);
				Clk                    : in std_logic				
				);
end component

component MUX 	
		port (M0, M1 , M2, M3          : in std_logic_vector (5 downto 0);
				Saida_mux 		 			 : out std_logic_vector (5 downto 0 );
				SelMux0, SelMux1			 : in std_logic_vector (1 downto 0)
				);
end component

component Registrador1
		port (Reg1in   : in std_logic_vector ( 5 downto 0);
				Reg1out  : out std_logic_vector (5 downto 0);
				Load1    : in std_logic;
				Clk      : in std_logic;
				Clr      : in std_logic
				);				
				
end component

component somador 
		port (SomaA, SomaB 	: in std_logic_vector (5 downto 0);
				carryout 		: out std_logic;
				saidasoma 		: out std_logic_vector (5 downto 0)
				);
end component	

component Registrador2
		port (Reg2in   : in std_logic_vector ( 5 downto 0);
				Reg2out  : out std_logic_vector (5 downto 0);
				Load2    : in std_logic;
				Clk      : in std_logic;
				Clr      : in std_logic
				);				
end component

signal
-- Signal da maquinas de estados.

-- Signal do codigo principal.
 Saida_total 												 : std_logic_vector (5 downto 0);
 --Re0,Re1,Re2,Re3 											 : std_logic_vector (4 downto 0);  -- signal de saida do registrador.
 A, A_temp, B, B_temp, C, C_temp, D, D_temp      : std_logic_vector (4 downto 0);  -- signal de entrada da primeira operação.
 W0, W1, W2, W3  : std_logic_vector (5 downto 0);  -- signal de entrada da segunda operação.
 I0, I1, I2, I3  : std_logic_vector (5 downto 0); 	-- signal de entrada do contador.
 J0, J1, J2, J3  : std_logic_vector (5 downto 0);	-- signal de entrada do mux.
 K               : std_logic_vector (5 downto 0); 	-- signal de entrada do SomaA
 O					  : std_logic_vector (5 downto 0); 	-- signal de entrada do registrador 1
 P					  : std_logic_vector (5 downto 0); 	-- 
 --Z					  : std_logic_vector (5 downto 0);  -- 
-- Load_ini		  : std_logic;								-- 
 --Load1			  : std_logic;								--.
 --Load2			  : std_logic; 							-- .
 
 
begin
	-- Equações das entradas das metrizes HT*HT^-1
	-- Concatenação das entradas.
	
	Re0_temp <= ('0' & Re0);
	Re1_temp <= ('0' & Re1);
	Re2_temp <= ('0' & Re2);
	Re3_temp <= ('0' & Re3);
	
	A <= Re0_temp + Re1_temp;
	C <= Re0_temp - Re1_temp;
	B <= Re2_temp + Re3_temp;
	D <= Re2_temp - Re3_temp;
	
	
	A_temp <= ('0' & A);
	B_temp <= ('0' & B);
	C_temp <= ('0' & C);
	D_temp <= ('0' & D);
	
	W0 <= A_temp + B_temp;
	W2 <= A_temp - B_temp;
	W1 <= C_temp + D_temp;
	W3 <= C_temp - D_temp;
	
	
	
	-- Ligaçao Start.
	Start : reg_inicial port map (Reg_entrada => Y11 , Reg_saida => Re0, Clk => Clk);
	Start : reg_inicial port map (Reg_entrada => Y12 , Reg_saida => Re1, Clk => Clk);
	Start : reg_inicial port map (Reg_entrada => Y21 , Reg_saida => Re3, Clk => Clk);
	Start : reg_inicial port map (Reg_entrada => Y22 , Reg_saida => Re4, Clk => CLk);


	-- Ligação contador absoluto com mux 4x1.
	ContadorABS : contador port map ( X0 => I0,	ABS0 => J0, Clk => Clk);
	ContadorABS : contador port map ( X1 => I1,	ABS1 => J1, Clk => Clk);
	ContadorABS : contador port map ( X2 => I2,	ABS2 => J2, Clk => Clk);
	ContadorABS : contador port map ( X3 => I3,	ABS3 => J4, Clk => Clk);
	
	--Ligação saida mux com somador.	
	Mux4x1 : Mux port map ( M0 => J0,	Saida_mux => K, Clk => Clk); 
        Mux4x1 : Mux port map ( M1 => J1,	Saida_mux => K, Clk => Clk); 
	Mux4x1 : Mux port map ( M2 => J2,	Saida_mux => K, Clk => Clk); 
	Mux4x1 : Mux port map ( M3 => J3,	Saida_mux => K, Clk => Clk); 
	
	-- Ligaçao somador com registrador 1.
	
	Soma : Somador port map (SomaA => K, Saidasoma => O , Clk => Clk);
   Soma : Somador port map (SomaB => P, Saidasoma => O , Clk => Clk);
	
	-- Ligaçao registrador 1 com registrador 2.
	
	Reg1 : Registrador1 port map (Reg1in => O , Reg1out => P, Clk => Clk);	
	
	-- Saida registrador 2.
	
	Reg2 : Registrador2 port map (Reg2in => P , Reg2out => SaidaFinal, Clk => Clk);
	
end architecture;	
	
