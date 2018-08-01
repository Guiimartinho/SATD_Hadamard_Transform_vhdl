---------------------------------------------------------------------------
-- Luiz Guilherme Martinho Sampaio Ito

-- Maquina de Estados  

-- Engenharia Eletrônica

-- Sistemas Digitais I
-----------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity maquina_estados_Funcao_SATD is
    port (
          Clk  		  	  : in std_logic; 			-- sinal de clock.
          start_maqui     : in std_logic;				-- inicio do sistema.
          Reg_Ini_Load    : out std_logic;			-- saida para o Load Register inicial.
			 Clr_Reg_Ini	  : out std_logic;			-- clear para o Registrador inicial.
			 Counter_saida	  : out std_logic;			-- saida para o contador.
			 Clr_Counter	  : out std_logic;			-- clear para o contador.
			 Reg_Load_1	     : out std_logic;			-- saida para o Load registrador 1.
			 Clr_Reg_1		  : out std_logic;			-- clear para o registrador 1.
			 Reg_Load_2		  : out std_logic;			-- saida para o Load registrador 2.	
			 Clr_Reg_2		  : out std_logic				-- clear para o registrador 2.
          );
end maquina_estados_Funcao_SATD;

architecture rtl of maquina_estados_Funcao_SATD is

-- Declaração dos estados da máquina.
type tipo_estado is (estado0,  			-- estado de start da descrição.
							estado1,  			-- estado do registrador_inicial.
							estado2, 			-- estado do contador para seletora do MUX. 
							estado3, 			-- estado do registrador 1 para a entrada do Somador e entrada do Registrador 2.
							estado4);			-- estado do Registrador 2.
						   
signal estado_atual, proximo_estado: tipo_estado; 		-- Sinais de estado atual e próximo estado.
    
  
begin

--================================================================
--   LóGICA DE INÍCIO
--================================================================
process(Clk, start_maqui, proximo_estado)
	
	begin
		if (start_maqui = '1') then
 		        
			estado_atual <= estado0;
		  
		elsif (Clk = '1' AND Clk'event) then
	      
			estado_atual <= proximo_estado;
	      
		end if;
	
end process;
--===================================================================     
          


--==================================================================
--     LÓGICA DE PRÓXIMO ESTADO
--==================================================================  
process(estado_atual, start_maqui)

begin
		
	case estado_atual is
		
		when estado0 =>
			if ( start_maqui = '0') then
				proximo_estado  <= estado1;
            else 
				proximo_estado <= estado0;
			end if;
			
		when estado1 =>
			if ( start_maqui = '0') then
				proximo_estado  <= estado2;
            else 
				proximo_estado <= estado1;
			end if;

		when estado2 =>
			if ( start_maqui = '0') then
				proximo_estado  <= estado3;
            else 
				proximo_estado <= estado2;
			end if;
			
		when estado3 =>
			if ( start_maqui = '0') then
				proximo_estado  <= estado4;
            else 
				proximo_estado <= estado3;
			end if;	
			
		when estado4 =>
			if ( start_maqui = '0') then
				proximo_estado  <= estado1;
            else 
				proximo_estado <= estado4;
			end if;	
	
	end case;

end process;
--=================================================================


--=================================================================
-- LÓGICA DE SAÍDA
--=================================================================  
process(estado_atual) 
	
begin
	case estado_atual IS
		
		when estado0 =>				-- lógica do estado inicial(0) Start.
		-- Registrador Inicial.		-- estado de start da descrição.
			Reg_Ini_Load <= '0'; 
			Clr_Reg_Ini <= '1';
			
		-- Registrador 1.	
			Reg_Load_1 <= '0';	   
			Clr_Reg_1 <= '1';
			
		-- Registrador 2.	
			Reg_Load_2 <= '0';		
			Clr_Reg_2 <= '1';
			
		-- Contador.	
			Counter_saida <= '0';	
			Clr_Counter <= '1';	
			
		when estado1 =>				-- lógica do estado1 e início do loop.
		-- Registrador Inicial.		-- estado do registrador_inicial.
			Reg_Ini_Load <= '1'; 
			Clr_Reg_Ini <= '0';
			
		-- Registrador 1.	
			Reg_Load_1 <= '1';	   
			Clr_Reg_1 <= '0';
			
		-- Registrador 2.	
			Reg_Load_2 <= '0';		
			Clr_Reg_2 <= '1';
			
		-- Contador.	
			Counter_saida <= '1';	
			Clr_Counter <= '0';			
			
			
		when estado2 =>				-- lógica do estado2.
		-- Registrador Inicial.		-- estado do contador para seletora do MUX. 
			Reg_Ini_Load <= '0'; 
			Clr_Reg_Ini <= '1';
			
		-- Registrador 1.	
			Reg_Load_1 <= '1';	   
			Clr_Reg_1 <= '0';
			
		-- Registrador 2.	
			Reg_Load_2 <= '0';		
			Clr_Reg_2 <= '1';
			
		-- Contador.	
			Counter_saida <= '1';	
			Clr_Counter <= '0';
		
	 when estado3 =>				-- lógica do estado3.
		-- Registrador Inicial. -- estado do registrador 1 para a entrada do Somador e entrada do Registrador 2. 
			Reg_Ini_Load <= '0'; 
			Clr_Reg_Ini <= '1';
			
		-- Registrador 1.	
			Reg_Load_1 <= '1';	   
			Clr_Reg_1 <= '0';
			
		-- Registrador 2.	
			Reg_Load_2 <= '0';		
			Clr_Reg_2 <= '1';
			
		-- Contador.	
			Counter_saida <= '1';	
			Clr_Counter <= '0';
	
   when estado4 =>				-- lógica do estado4.
		-- Registrador Inicial. -- estado do Registrador 2.
			Reg_Ini_Load <= '0'; 
			Clr_Reg_Ini <= '1';
			
		-- Registrador 1.	
			Reg_Load_1 <= '1';	   
			Clr_Reg_1 <= '0';
			
		-- Registrador 2.	
			Reg_Load_2 <= '1';		
			Clr_Reg_2 <= '0';
			
		-- Contador.	
			Counter_saida <= '0';	
			Clr_Counter <= '1';	
			
	end case;
		
end process;
	
end rtl;
