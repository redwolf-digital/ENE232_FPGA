----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 03:04:59 PM
-- Design Name: 
-- Module Name: timer1us - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer1us is
    Port ( clk, reset : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (15 downto 0);
           tp : out STD_LOGIC);
end timer1us;

architecture Behavioral of timer1us is
    constant n : natural := 16;
    constant M : natural := 125; -- counting constants
    signal c_reg, c_next : unsigned(n-1 downto 0);
    signal is_0 : std_logic;
begin
    -- regsiters
    process (clk,reset)
    begin  
       if reset = '1' then
          c_reg <= to_unsigned(M-1, n);
       elsif (clk'event and clk = '1') then
          c_reg <= c_next;
       end if;
    end process;
    -- next state function
	is_0 <= '1' when c_reg = 0 else
	        '0';		
	c_next <= to_unsigned(M-1,n) when is_0='1' else
	          c_reg-1;			
    q <= std_logic_vector(c_reg);
    tp <= is_0;
end Behavioral;
