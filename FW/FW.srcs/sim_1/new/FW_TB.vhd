----------------------------------------------------------------------------------
-- REDWOLF DiGiTAL
-- 5-11-2023
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FW_TB is
--  Port ( );
end FW_TB;

architecture Behavioral of FW_TB is

    component FW is
        Port ( clk, reset : in STD_LOGIC;
               sp : in STD_LOGIC;
               led : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    -- input
    signal clk, reset, sp : std_logic;
    -- output
    signal led : std_logic_vector (7 downto 0);
    -- Tclk  constant
    constant Tclk : time := 8 ns;
    
begin
    -- uut component
    timer_u : FW
    port map (
       clk => clk,
       reset => reset,
       sp => sp,
       led => led
    );
    
    -- simulation clock
    process
    begin
        clk <= '0';
        wait for Tclk/2;
        clk <= '1';
        wait for Tclk/2;
    end process;
    reset <= '1', '0' after 10.3*Tclk;
    
    -- pattern gen.
    process
    begin
        sp <= '0';
        wait for 200 us;
        sp <= '1';
        wait for 200 us;
    end process;
        
end Behavioral;
