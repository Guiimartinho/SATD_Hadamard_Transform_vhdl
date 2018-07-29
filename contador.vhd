library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity contador is
	port ( Clk : in std_logic ;
			 Clrcount, X : in std_logic ;				-- Entradas do contador
			 ABSS1, ABSS0 : buffer std_logic_vector(1 downto 0) ) ; 	-- Saidas do contador
end contador ;

architecture Behavior of contador is
begin

process ( Clk )
	begin		-- Inicio da lógica de contagem crescente de 1 bit
		if Clk'event AND Clk = '1' then
			if Clrcount = '1' then
				ABSS1 <= "00" ; ABSS0 <= "00" ;
			elsif X = '1' then
				if ABSS0 = "00" then
					ABSS0 <= "01" ;
					if ABSS1 = "00" then
						ABSS1 <= "00";
					else
						ABSS1 <= ABSS1 + '1' ;
					end if ;
				else
					ABSS0 <= ABSS0 + '1' ;
				end if ;
			end if ;
		end if;
		
end process;
end Behavior ;
