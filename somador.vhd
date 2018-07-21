--libraries to be used are specified here
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
--entity declaration with port definitions
entity somador is
port(
  SomaA     : in std_logic_vector(5 downto 0);  -- 6 bit input sumA
  SomaB     : in std_logic_vector(5 downto 0);  -- 6 bit input sumB
  saidasoma : out std_logic_vector(5 downto 0); -- 6 bit sum
  carryout  : out std_logic   -- carry out.
);
end somador;
 
--architecture of entity
architecture Behavioral of somador is
-- temporary signal declarations(for intermediate carry's).
  signal c0,c1,c2,c3,c4,c5 : std_logic := '0';
begin  
 
  --first full adder
  saidasoma(0) <= SomaA(0) xor SomaB(0);  -- sum calculation
  c0 <= SomaA(0) and SomaB(0);            -- carry calculation
   
  --second full adder
  saidasoma(1) <= SomaA(1) xor SomaB(1) xor c0;
  c1 <= (SomaA(1) and SomaB(1)) or (SomaA(1) and c0) or (SomaB(1) and c0);
 
  --third full adder
  saidasoma(2) <= SomaA(2) xor SomaB(2) xor c1;
  c2 <= (SomaA(2) and SomaB(2)) or (SomaA(2) and c1) or (SomaB(2) and c1);
 
  --fourth(final) full adder
  saidasoma(3) <= SomaA(3) xor SomaB(3) xor c2;
  c3 <= (SomaA(3) and SomaB(3)) or (SomaA(3) and c2) or (SomaB(3) and c2);
 
  --fifith(final) full adder
  saidasoma(4) <= SomaA(4) xor SomaB(4) xor c2;
  c4 <= (SomaA(4) and SomaB(4)) or (SomaA(4) and c2) or (SomaB(4) and c3);
 
 --sexth(final) full adder
  saidasoma(5) <= SomaA(5) xor SomaB(5) xor c2;
  c5 <= (SomaA(5) and SomaB(3)) or (SomaA(5) and c2) or (SomaB(5) and c4);
 

  --final carry assignment
  carryout <= c5;
 
end Behavioral;
