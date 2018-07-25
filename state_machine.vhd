--
-- Curso de FPGA WR Kits Channel
--
--
-- Aula 19: Máquina de Estados
--
-- Kit FPGA EE02-SOQ
--
-- Adquira em http://www.professoremersonmartins.com.br/site/products/KIT-FPGA-%252d-EE02-%252d-SOQ.html
--
--
-- Autor: Eng. Wagner Rambo     Data: Outubro de 2015
--
-- www.wrkits.com.br | facebook.com/wrkits | youtube.com/user/canalwrkits
--

	entity state_machine is
	port(
			clk		:  in   bit;							 -- clock para borda de subida
			rst      :  in   bit;							 -- rst = 1, q = 00
			q        : inout bit_vector(1 downto 0));  -- saida
	end state_machine;
	
	architecture hardware of state_machine is
	begin
	  my_process : process(clk, rst)
	  begin
       if(rst = '1') then q <= "00";					-- estado inicial
		 elsif(clk'event and clk = '1') then 			-- ciclo de estados 
		   case q is
			  when "00" => q <= "01";
			  when "01" => q <= "11";
			  when "11" => q <= "10";
			  when "10" => q <= "00";
			end case;
		 end if;
	  end process my_process;
	end hardware;

























