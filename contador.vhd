library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity contador is
	port ( Clk : in std_logic ;
			 Clrcount, X : in std_logic ;				-- Entradas do contador
			 ABSS1, ABSS0 : buffer std_logic_vector(1 downto 1) ) ; 	-- Saidas do contador
end BCDcount ;

architecture Behavior of contador is
begin

process ( Clk )
	begin		-- Inicio da lógica de contagem crescente de 1 bit
		if Clk'event AND Clk = '1' then
			if Clrcount = '1' then
				ABSS1 <= "0" ; ABSS0 <= "0" ;
			elsif X = '1' then
				if ABSS0 = "0" then
					ABSS0 <= "1" ;
					if ABSS1 = "0" then
						ABSS1 <= "0";
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
