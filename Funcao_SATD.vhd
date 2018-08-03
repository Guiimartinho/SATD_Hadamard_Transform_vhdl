library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity Funcao_SATD is

 port (
		Y11, Y12, Y21, Y22 			: in std_logic_vector (3 downto 0); -- entradas do bloco.
		Start_SATD						: in std_logic;							-- Start da descrição.
		Clk								: in std_logic;
		SaidaFinal         			: out std_logic_vector(5 downto 0)  -- saída final da descrição.
		); 
		
		
end entity;

architecture comportamento of Funcao_SATD is

component Reg_inicial 																					-- Registrador de Start.
		port (Regin0, Regin1, Regin2, Regin3 		: in std_logic_vector(3 downto 0);
				Regout0,Regout1,Regout2,Regout3  	: out std_logic_vector(3 downto 0);
				Load_ini										: in std_logic;	
				Clk                                 : in std_logic;
				Clr											: in std_logic
				);
end component;

component contador -- Contador do valor absoluto.
		port ( 
				--Clk 				: in std_logic ;
				Clrcount 		: in std_logic ;				-- Entradas do contador
				X					: in std_logic;
				ABSS			 	: buffer std_logic_vector(1 downto 0)
				);				
				
end component;

component MUX 	
		port (M0, M1 , M2, M3          : in std_logic_vector (5 downto 0);
				Saida_mux 		 			 : out std_logic_vector (5 downto 0 );
				SelMux						 : in std_logic_vector (1 downto 0)
				);
end component;

component Registrador1
		port (Reg1in   : in std_logic_vector ( 5 downto 0);
				Reg1out  : out std_logic_vector (5 downto 0);
				Load1    : in std_logic;
				Clk      : in std_logic;
				Clr      : in std_logic		
				);								
end component;

component somador 
		port (SomaA, SomaB 	: in std_logic_vector (5 downto 0);
				carryout 		: out std_logic;
				saidasoma 		: out std_logic_vector (5 downto 0)
				);
end component;	

component Registrador2
		port (Reg2in   : in std_logic_vector ( 5 downto 0);
				Reg2out  : out std_logic_vector (5 downto 0);
				Load2    : in std_logic;
				Clk      : in std_logic;
				Clr      : in std_logic
				);				
end component;

component maquina_estados_Funcao_SATD
		 port (
          Clk  		  	  : in std_logic; 			-- sinal de clock.
          start_maqui	  : in std_logic;				-- inicio do sistema.
          Reg_Ini_Load    : out std_logic;			-- saida para o Load Register inicial.
			 Clr_Reg_Ini	  : out std_logic;			-- clear para o Registrador inicial.
			 Counter_saida	  : out std_logic;			-- saida para o contador.
			 Clr_Counter	  : out std_logic;			-- clear para o contador.
			 Reg_Load_1	     : out std_logic;			-- saida para o Load registrador 1.
			 Clr_Reg_1		  : out std_logic;			-- clear para o registrador 1.
			 Reg_Load_2		  : out std_logic;			-- saida para o Load registrador 2.	
			 Clr_Reg_2		  : out std_logic				-- clear para o registrador 2.
          );

end component;


-- Signal da maquinas de estados.

-- Signal do codigo principal.
 signal Saida_total 												  		: std_logic_vector (5 downto 0);	 -- saida total da descrição.

 signal A, B, C, D     													: std_logic_vector (4 downto 0);  -- signal de entrada da primeira operação.
 signal A_temp, B_temp, C_temp, D_temp								: std_logic_vector (5 downto 0);  -- signal (A,B,C,D) + '1' bit.
 signal ini0, ini1, ini2, ini3										: std_logic_vector (3 downto 0);  -- signal para ligação Entrada Descrição com Regs_ini.
 signal Re0_tempOut, Re1_tempOut, Re2_tempOut, Re3_tempOut	: std_logic_vector (3 downto 0);  -- signal para saída do resgistrador inicial.
 signal W0, W1, W2, W3  										 	 	: std_logic_vector (5 downto 0);  -- signal de entrada da segunda operação.
 signal I0, I1, I2, I3  										  		: std_logic_vector (5 downto 0);  -- signal de entrada do contador.
 signal J0, J1, J2, J3  								        		: std_logic_vector (5 downto 0);	 -- signal de entrada do mux.
 signal K               										  		: std_logic_vector (5 downto 0);  -- signal de entrada do SomaA.
 signal O															  		: std_logic_vector (5 downto 0);  -- signal de entrada do registrador 1.
 signal P													  	     		: std_logic_vector (5 downto 0);  -- 
 signal reg_cont0, reg_cont1, reg_cont2, reg_cont3				: std_logic_vector (5 downto 0);  -- W0,W1,W2,W3 para entrador do ABSS(contador).
 signal cont_selmux														: std_logic_vector (1 downto 0);  -- signal para seletora do MUX.
 signal start_funcao														: std_logic; 							 -- signal de start para o contador.
 
 
 -- Signals da FSM
 signal Signal_Reg_Load_ini		   : std_logic;		
 signal Signal_Clr_Load_ini		   : std_logic;
 
 signal Signal_Reg_Load1			   : std_logic;
 signal Signal_Clr_Load1   			: std_logic;
 
 signal Signal_Reg_Load2			   : std_logic;
 signal Signal_Clr_Load2  				: std_logic;
 
 signal signal_counter					: std_logic;
 signal signal_clr_counter				: std_logic;
 

 
 
 
 
 begin
	-- Equações das entradas das metrizes HT*HT^-1
	-- Concatenação das entradas.
	ini0 <= Y11;
	ini1 <= Y21;
   ini2 <= Y12;
	ini3 <= Y22;
	start_funcao <= Start_SATD;
	
	
--with ini0(3) select
	--J0 <= ini0               
	--when '0',
		--	(not(ini0) + "01") when others;
			
	--with ini1(3) select
	--J1 <= ini1               
	--when '0',
		--	(not(ini1) + "01") when others; 		
			
--	with ini2(3) select
--	J2 <= ini2		      	 
--	when '0',
--			(not(ini2) + "01") when others; 		
--			
--	with ini3(3) select
--	J3 <= ini3		 	       
--	when '0',
--			(not(ini3) + "01") when others; 
			
	
	

	
	A <= (('0' & Re0_tempOut) + ('0' & Re1_tempOut));  -- Re0_tempOut(4 bits) + Re1_tempOut(4 bits)
	C <= (('0' & Re0_tempOut) - ('0' & Re1_tempOut));
	B <= (('0' & Re2_tempOut) + ('0' & Re3_tempOut));
	D <= (('0' & Re2_tempOut) - ('0' & Re3_tempOut));
	
	
	A_temp <= ('0' & A);
	B_temp <= ('0' & B);
	C_temp <= ('0' & C);
	D_temp <= ('0' & D);
	
	W0 <= (A_temp + B_temp);
	W2 <= (A_temp - B_temp);
	W1 <= (C_temp + D_temp);
	W3 <= (C_temp - D_temp);
	
	
	
	-- Ligaçao Start.
	-- Port maps para inicio da descrição.
	-- Registrador inicial.
	-- Entrada de dados.
	Start : Reg_inicial port map (Regin0 => ini0, Regout0 => Re0_tempOut,		
											Regin1 => ini1, Regout1 => Re1_tempOut,		
											Regin2 => ini2, Regout2 => Re2_tempOut,		
											Regin3 => ini3, Regout3 => Re3_tempOut,
											Load_ini => Signal_Reg_Load_ini,
											Clr => Signal_Clr_Load_ini,
											Clk => CLk
											);	
											
   --	Ligação Registrador_inicial com o contador.
		J0 <= W0;
		J1 <= W1;
		J2 <= W2;
		J3 <= W3;

	-- Ligação contador absoluto com mux 4x1.
	-- Port map para ligação Contador para Mux.
	ContadorABS : contador port map (
												ABSS => cont_selmux,
												X => signal_counter,
												Clrcount => signal_clr_counter																							
											  	);
	
	--Ligação saida mux com somador.
	-- Port map Mux para Somador A.
	Mux4x1 : Mux port map ( M0 => J0,	 
									M1 => J1,	
									M2 => J2,	 
									M3 => J3,	
									Saida_mux => K,
									SelMux => cont_selmux
									); 
	
	-- Ligaçao somador com registrador 1.
	-- Post map Somador para Registrador 1
	
	Soma : Somador port map (SomaA => K, 
									 saidasoma => O, 
									 SomaB => P 
									 );
	
	
	-- Ligaçao registrador 1 com registrador 2.
	-- Port map Registrador 1 para registrador 2.
	Reg1 : Registrador1 port map (Reg1in(5 downto 0) => O(5 downto 0), 	
											Reg1out => P,
											Load1 => Signal_Reg_Load1,
											Clr => Signal_Clr_Load1,
											Clk => Clk
											);	
	
	-- Saida registrador 2.	
	Reg2 : Registrador2 port map (Reg2in => P,
											Reg2out => SaidaFinal,
											Load2 => Signal_Reg_Load2,
											Clr => Signal_Clr_Load2,
											Clk => Clk
											);
											
	FSM : maquina_estados_Funcao_SATD port map(
															 start_maqui  => start_funcao,	  
															 Reg_Ini_Load => Signal_Reg_Load_ini,    
															 Clr_Reg_Ini => Signal_Clr_Load_ini,
															 
															 Counter_saida => signal_counter,	  
															 Clr_Counter => signal_clr_counter,
															 
															 Reg_Load_1 => Signal_Reg_Load1,	     
															 Clr_Reg_1 => Signal_Clr_Load1,
															 
															 Reg_Load_2 => Signal_Reg_Load2,		  
															 Clr_Reg_2 => Signal_Clr_Load2,
															 Clk => Clk															 	
															);										
											
											
	
end architecture;	
	

