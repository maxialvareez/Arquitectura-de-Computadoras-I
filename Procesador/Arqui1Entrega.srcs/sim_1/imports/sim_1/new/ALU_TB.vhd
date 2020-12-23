library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_TB is
--  Port ( );
end ALU_TB;

architecture Behavioral of ALU_TB is

COMPONENT ALU 
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           b : in STD_LOGIC_VECTOR (31 downto 0);
           op : in STD_LOGIC_VECTOR (2 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end component;

    SIGNAL a : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL b : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL op : STD_LOGIC_VECTOR (2 downto 0);
    SIGNAL result : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL zero : STD_LOGIC;
    
begin

uut: ALU
    Port map( a=>a,
              b=>b,
              op=>op,
              result=>result,
              zero=>zero);
              
 tb_process: process
begin

a<= X"50005231";
b<= X"00015231";
op<= "000";
wait for 20 ns;
op<= "001";
wait for 20 ns;
op<= "010";
wait for 20 ns;
op<= "110";
wait for 20 ns;
op<= "111";
wait for 20 ns;
op<= "100";
wait;

end process;

end Behavioral;
