----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2019 14:26:18
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_signed.all;


entity ALU is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           op : in STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
    signal resultado : STD_LOGIC_VECTOR (31 downto 0); --señal interna al proceso "mux 8a1"
    begin
        
           process (op,a,b) --lista de sensibilidad
            begin
               case (op) is
                  when "000" => resultado <= (a AND b);
                  when "001" => resultado <= (a OR b);
                  when "010" => resultado <= (a + b);
                  when "110" => resultado <= (a - b);
                  when "111" => if ( a < b ) then resultado <= X"00000001"; else resultado <= X"00000000"; end if;
                  when "100" => resultado <= b (15 downto 0) & X"0000";
                  when others => resultado <= X"00000000";
               end case;
            end process;
        
        result <= resultado;
        
        zero <= '1' when resultado = X"0000" else '0';
                    
    
end Behavioral;
