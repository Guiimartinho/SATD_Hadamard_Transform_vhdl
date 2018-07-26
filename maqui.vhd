library ieee;
use ieee.std_logic_1164.all;



entity maqui is
	port( reset, clk	: in	std_logic;
			x		: 	in std_logic;
			y		:  in std_logic;
			q0		: out std_logic;
			q1		: out std_logic
		);
end entity;

architecture rtl of maqui is

type mis_estados is (estado_ini, 		-- estado inicial.
							estado2, 			-- estado MUX do ABSW0.
							estado3, 			-- estado do Registrador 1.
							estado4, 			-- estado do Registrador 2 e saída final da descrição.
							estado5, 			-- estado MUX do ABSW1.
							estado6, 			-- estado MUX do ABSW2.
							estado7);			-- estado MUX do ABSW3.

signal presente:mis_estados:=estado_ini;

begin

process (reset, clk)
begin
 if reset='1' then
	presente <= estado_ini;
 elsif clk='1' and clk'event then
	case presente is
 
	when estado_ini=>
	if (x='0' and y='1') then
		presente <=	estado2;
	elsif (x='0' and y='0') then
		presente <=	estado_ini;
	end if;	

	when estado2=>
	if (x='0' and y='1') then
		presente <=estado3;
	elsif (x='0' and y='0') then
		presente <=estado2;
	end if;	
 
	when estado3=>
	if (x='0' and y='1') then
		presente <=	estado4;
	elsif (x='0' and y='0') then
		presente <=estado3;
	end if;	
 
	when estado4=>
	if (x='0' and y='1') then
		presente <=	estado5;
	elsif(x='1' and y='0') then
		presente <=	estado6;
	elsif (x='1' and y='1') then
		presente <=	estado7;
	elsif (x='0' and y='0') then
		presente <=	estado4;
	end if;	
	
	when estado5=>
	if (x='0' and y='1') then
		presente <=	estado3;
	elsif (x='0' and y='0') then
		presente <=	estado5;
	end if;

	when estado6=>
	if (x='0' and y='1') then
		presente <=	estado3;
	elsif (x='0' and y='0') then
		presente <=	estado6;
	end if;	
	
	when estado7=>
	if (x = '0' and y = '1') then
		presente <=	estado3;
	elsif (x = '0' and y = '0') then
		presente <=	estado7;
	end if;	

	end case ;
	end if;
end process;

process(presente)
begin

	case presente is

	when estado_ini => q0 <= '0'; 
		q1 <= '0';
	
	
	when estado2 => q0 <= '0'; 
		q1 <= '0';
	
	when estado3 => q0 <= '0'; 
		q1 <= '0';

	
	when estado4 => q0 <= '0'; 
		q1 <= '1';	
		
	when estado5 =>q0<='0'; 
		q1 <= '0';
		
	when estado6=> q0 <='0'; 
		q1 <= '0';
		
	when estado7 => q0 <= '0'; 
		q1 <= '0';
	
	end case;
end process;
end rtl;
