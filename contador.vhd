library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity contador is
	port ( Clk 			 : in std_logic ;
			 Clrcount, X : in std_logic ;				-- Entradas do contador
			 ABSS			 : buffer std_logic_vector(1 downto 0) ) ; 	-- Saidas do contador
end contador ;

architecture Behavior of contador is
begin

process ( Clk )
	begin		-- Inicio da lógica de contagem crescente de 1 bit
		if Clk'event AND Clk = '1' then
			if Clrcount = '1' then
				ABSS <= "00";
			else
				if (X <= '1') then
					ABSS <= "00";
				elsif (ABSS <= "00") then
					ABSS <= "01";
				elsif (ABSS <= "01") then
					ABSS <= "10";
				elsif (ABSS <= "10") then
					ABSS <= "11";
				end if;			
			end if ;
		end if;
		
end process;
end Behavior ;
