library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity old_contador is
    PORT (
        Clk    : IN  STD_LOGIC;
        creset : IN  STD_LOGIC;
        cload  : IN  STD_LOGIC;
        X      : IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
        ABSS    : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
    );
end old_contador;
 
architecture Behavioral of old_contador is
    -- Señal temporal para el contador.
    signal cnt_tmp: STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
begin
    proceso_contador: process (cload, creset, Clk, X) begin
        if creset = '1' then
            cnt_tmp <= "000000";
        elsif cload = '1' then
            cnt_tmp <= X;
        elsif rising_edge(Clk) then
            if cnt_tmp = "100101" then
                cnt_tmp <= "000000";
            else
                cnt_tmp <= cnt_tmp + 1;
            end if;
        end if;
    end process;
 
    ABSS <= cnt_tmp;
end Behavioral;
