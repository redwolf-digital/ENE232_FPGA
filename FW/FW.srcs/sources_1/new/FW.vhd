----------------------------------------------------------------------------------
-- REDWOLF DiGiTAL
-- 5-11-2023
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FW is
    Port ( clk, reset : in STD_LOGIC;
           sp : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (7 downto 0));
end FW;

architecture Behavioral of FW is
    
    component timer1us is
        Port ( clk, reset : in STD_LOGIC;
               q : out STD_LOGIC_VECTOR (15 downto 0);
               tp : out STD_LOGIC);
    end component;
    constant n : natural := 20;
    constant M1 : natural := 200000;        -- 200000 Normal speed
    constant M2 : natural := 100000;        -- 100000 Fast speed
    signal p1us, en : std_logic;
    signal c_reg, c_next, M : unsigned(n-1 downto 0);
    signal c_reg102, c_next102, M102 : unsigned(n-1 downto 0);
    
    signal r_reg, r_next : std_logic_vector(7 downto 0);
    signal r_reg102, r_next102 : std_logic_vector(7 downto 0);
    
begin
    timer_u : timer1us
    port map (
       clk => clk,
       reset => reset,
       q => open,
       tp => p1us
    );
    
    
    -- registers 1
    -- reg c : counter register
    -- reg p : shift register
    process (clk,reset)
    begin  
       if reset = '1' then
          c_reg <= to_unsigned(M1-1, n);
          r_reg <= (0 => '1', others => '0');
       elsif (clk'event and clk = '1') then
          c_reg <= c_next;
          r_reg <= r_next;
       end if;
    end process;
    
    r_next <= r_reg when en = '0' else
              r_reg(6 downto 0) & r_reg(7);
    
    en <= '1' when c_reg = 0 and p1us = '1' else
          '0';
    c_next <= c_reg when p1us = '0' else
              M when en = '1' else
              c_reg - 1;
    M <= TO_UNSIGNED(M2-1, n) when sp = '1' else TO_UNSIGNED(M1-1, n);
    
    
    -- registers 2
    -- reg c : counter register
    -- reg p : shift register
    process (clk,reset)
    begin  
       if reset = '1' then
          c_reg102 <= to_unsigned(M2-1, n);
          r_reg102 <= (0 => '1', others => '0');
       elsif (clk'event and clk = '1') then
          c_reg102 <= c_next102;
          r_reg102 <= r_next102;
       end if;
    end process;
    
    r_next102 <= r_reg102 when en = '0' else
              r_reg(0) & r_reg(7 downto 1);
    
    en <= '1' when c_reg = 0 and p1us = '1' else
          '0';
    c_next102 <= c_reg when p1us = '0' else
              M102 when en = '1' else
              c_reg102 - 1;
    M102 <= TO_UNSIGNED(M1-1, n) when sp = '1' else TO_UNSIGNED(M2-1, n);
    
    
    -- Output block
    led <= r_reg or r_reg102;

end Behavioral;
