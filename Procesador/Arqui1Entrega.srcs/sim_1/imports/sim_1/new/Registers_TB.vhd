----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2019 15:11:30
-- Design Name: 
-- Module Name: Registers_TB - Behavioral
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

entity Registers_TB is
--  Port ( );
end Registers_TB;

architecture Behavioral of Registers_TB is

COMPONENT Registers
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           wr : in STD_LOGIC;
           reg1_rd : in STD_LOGIC_VECTOR (4 downto 0);
           reg2_rd : in STD_LOGIC_VECTOR (4 downto 0);
           reg_wr : in STD_LOGIC_VECTOR (4 downto 0);
           data_wr : in STD_LOGIC_VECTOR (31 downto 0);
           data1_rd : out STD_LOGIC_VECTOR (31 downto 0);
           data2_rd : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

  SIGNAL   clk : STD_LOGIC;
  SIGNAL   reset : STD_LOGIC;
  SIGNAL   wr : STD_LOGIC;
  SIGNAL   reg1_rd : STD_LOGIC_VECTOR (4 downto 0);
  SIGNAL   reg2_rd : STD_LOGIC_VECTOR (4 downto 0);
  SIGNAL   reg_wr : STD_LOGIC_VECTOR (4 downto 0);
  SIGNAL   data_wr : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL   data1_rd : STD_LOGIC_VECTOR (31 downto 0);
  SIGNAL   data2_rd : STD_LOGIC_VECTOR (31 downto 0);

begin

uut: Registers
    Port map (clk => clk,
              reset => reset,
              wr => wr,
              reg1_rd => reg1_rd,
              reg2_rd => reg2_rd,
              reg_wr => reg_wr,
              data_wr => data_wr,
              data1_rd => data1_rd,
              data2_rd => data2_rd);
              
 tb_process: process
 begin 
   wr <= '1';
   for i in 0 to 31 loop
    reg_wr <= conv_std_logic_vector(i,5);
    data_wr <= conv_std_logic_vector(i+1,32);
    wait for 10 ns;
    end loop;
    
 end process;

    process
    begin 
    clk <= '1';
    wait for 10 ns;
    clk <= '0';
    wait;
    end process;
    
    process 
    begin 
    reset <= '1';
    wait;
    end process;


end Behavioral;
