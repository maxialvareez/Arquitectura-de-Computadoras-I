----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2019 14:23:11
-- Design Name: 
-- Module Name: Registers - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registers is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           wr : in STD_LOGIC;
           reg1_rd : in STD_LOGIC_VECTOR (4 downto 0);
           reg2_rd : in STD_LOGIC_VECTOR (4 downto 0);
           reg_wr : in STD_LOGIC_VECTOR (4 downto 0);
           data_wr : in STD_LOGIC_VECTOR (31 downto 0);
           data1_rd : out STD_LOGIC_VECTOR (31 downto 0);
           data2_rd : out STD_LOGIC_VECTOR (31 downto 0));
end Registers;

architecture Behavioral of Registers is
type t_reg is array (31 downto 0) of std_logic_vector (31 downto 0);
signal reg: t_reg;

begin
    process(clk,reset)
        begin
        if (reset = '1') then
            reg <= (others =>X"00000000");
        elsif falling_edge(clk) then
            if (wr = '1') then
            reg(conv_integer(reg_wr)) <= data_wr;
           end if;
         end if;
       end process;

      data1_rd <= x"00000000" when reg1_rd = "00000"
        else reg(conv_integer(reg1_rd));
        
      data2_rd <= x"00000000" when reg2_rd = "00000"
        else reg(conv_integer(reg2_rd));
        
end Behavioral;