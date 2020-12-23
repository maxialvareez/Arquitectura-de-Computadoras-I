library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Multicycle_MIPS is
port(
	clk       : in  std_logic;
	reset     : in  std_logic;
	addr      : out std_logic_vector(31 downto 0);
	RdStb     : out std_logic;
	WrStb     : out std_logic;
	DataOut   : out std_logic_vector(31 downto 0);
	DataIn    : in  std_logic_vector(31 downto 0));
end Multicycle_MIPS; 

architecture Multicycle_MIPS_arch of Multicycle_MIPS is 

--DECLARACION DE COMPONENTES--

    -- Componente ALU --
    COMPONENT ALU
        Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
               b : in STD_LOGIC_VECTOR (31 downto 0);
               op : in STD_LOGIC_VECTOR (2 downto 0);
               result : out STD_LOGIC_VECTOR (31 downto 0);
               zero : out STD_LOGIC);
    end component;
    
    -- Componente Registro --
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
    
    -- Componente ControlUnit --
    COMPONENT ControlUnit
        Port ( clk : in STD_LOGIC;
               Reset : in STD_LOGIC;
               OpCode:  in STD_LOGIC_VECTOR(5 downto 0);
               PCSource: out STD_LOGIC_VECTOR(1 downto 0);
               TargetWrite: out STD_LOGIC;
               AluOp: out STD_LOGIC_VECTOR(1 downto 0);
               AluSelA: out STD_LOGIC;
               AluSelB: out STD_LOGIC_VECTOR(1 downto 0);
               RegWrite: out STD_LOGIC;
               RegDst: out STD_LOGIC;
               PCWrite: out STD_LOGIC;
               PCWriteCond: out STD_LOGIC;
               IorD: out STD_LOGIC;
               MemRead: out STD_LOGIC;
               MemWrite: out STD_LOGIC;
               IRWrite: out STD_LOGIC;
               MemToReg: out STD_LOGIC);
    end COMPONENT;

----------------------------------------------------------

-- DECLARACION DE SEÑALES--

    -- Sección ALU --
    SIGNAL a : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL b : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL op : STD_LOGIC_VECTOR (2 downto 0);
    SIGNAL result : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL zero : STD_LOGIC;
    
    -- Sección Registros --
    SIGNAL   wr : STD_LOGIC;
    SIGNAL   reg1_rd : STD_LOGIC_VECTOR (4 downto 0);
    SIGNAL   reg2_rd : STD_LOGIC_VECTOR (4 downto 0);
    SIGNAL   reg_wr : STD_LOGIC_VECTOR (4 downto 0);
    SIGNAL   data_wr : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL   data1_rd : STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL   data2_rd : STD_LOGIC_VECTOR (31 downto 0);
    
    -- Sección Control Unit --
    SIGNAL     OpCode: STD_LOGIC_VECTOR(5 downto 0);
    SIGNAL     PCSource: STD_LOGIC_VECTOR(1 downto 0);
    SIGNAL     TargetWrite: STD_LOGIC;
    SIGNAL     AluOp: STD_LOGIC_VECTOR(1 downto 0);
    SIGNAL     AluSelA: STD_LOGIC;
    SIGNAL     AluSelB: STD_LOGIC_VECTOR(1 downto 0);
    SIGNAL     RegWrite: STD_LOGIC;
    SIGNAL     RegDst: STD_LOGIC;
    SIGNAL     PCWrite: STD_LOGIC;
    SIGNAL     PCWriteCond: STD_LOGIC;
    SIGNAL     IorD: STD_LOGIC;
    SIGNAL     MemRead: STD_LOGIC;
    SIGNAL     MemWrite: STD_LOGIC;
    SIGNAL     IRWrite: STD_LOGIC;
    SIGNAL     MemToReg: STD_LOGIC;
    
    -- Señales internas -- 
    SIGNAL     PC: STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL     next_PC: STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL     instR: STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL     target: STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL     JumpAdress: STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL     SignoExtendido: STD_LOGIC_VECTOR(31 downto 0);
    SIGNAL     SignoShift: STD_LOGIC_VECTOR(31 downto 0);
    
begin

PortAlu: ALU
    Port map( a=>a,
              b=>b,
              op=>op,
              result=>result,
              zero=>zero);

PortReg: Registers
    Port map (clk => clk,
              reset => reset,
              wr => RegWrite,
              reg1_rd => instR(25 downto 21),
              reg2_rd => instR(20 downto 16),
              reg_wr => reg_wr,
              data_wr => data_wr,
              data1_rd => data1_rd,
              data2_rd => data2_rd);
              
PortCU: ControlUnit
    Port map (clk => clk,
              reset => reset,
              OpCode => instR(31 downto 26),
              PCSource => PCSource,
              TargetWrite => TargetWrite,
              AluOp => AluOp,
              AluSelA => AluSelA,
              AluSelB => AluSelB,
              RegWrite => RegWrite,
              RegDst => RegDst,
              PCWrite => PCWrite,
              PCWriteCond => PCWriteCond,
              IorD => IorD,
              MemRead => RdStb,
              MemWrite => WrStb,
              IRWrite => IRWrite,
              MemToReg => MemToReg);
              
-- Proceso Registro: PC --          
    process (clk, reset)
        begin 
            if reset = '1' then 
               PC <= (others => '0');
            elsif rising_edge(clk) then
                if ((PCWrite = '1') or (PCWriteCond = '1' and zero = '1')) then
                   PC <= next_PC;
                end if;
            end if;
                
-- Proceso Registro: Instruction Register --          
            if reset = '1' then 
                instR <= (others => '0');
            elsif rising_edge(clk) then
                if (IRWrite = '1') then
                    instR <= DataIn;
                end if;
            end if;
            
-- Proceso Registro: Target --

            if reset = '1' then
                target <= (others => '0');
            elsif rising_edge(clk) then
                if (TargetWrite = '1') then
                    target <= result;
                end if;
            end if;
     end process;

-- Sign Extend --
SignoExtendido <= x"0000" & instR(15 downto 0) when (instR(15) = '0') else  (x"FFFF" & instR(15 downto 0));

-- Shift Left (Signo Extendido) --
SignoShift <= SignoExtendido(29 downto 0) & "00";

---- Shift Left (Concatenacion) "Jump Adress" --
--JumpAdress <=  PC(31 downto 28) & DataIn(25 downto 0) & "00"; 

-- Proceso Mux 2 a 1: a/ALU --
a <= data1_rd WHEN AluSelA = '1' ELSE
                PC;

-- Proceso Mux 2 a 1: PC/AluOut --
addr <= result WHEN IorD ='1' ELSE 
                PC;

-- Proceso Mux 2 a 1: IR/Write Register --
reg_wr <= instR(15 downto 11) WHEN RegDst = '1' ELSE
                    instR(20 downto 16);

-- Proceso Mux 2 a 1: IR/Write Data --
data_wr <= DataIn WHEN MemtoReg = '1' ELSE
                    result;

-- Proceso Mux 4 a 1: result/Target --
process (PCSource,result,target)
begin
    case PCSource is
        when "00" => next_pc <= result;
        when "01" => next_pc <= target;
        when others => next_pc <= result;
    end case;
end process;

-- Proceso Mux 4 a 1: b/ALU --
process (AluSelB,data2_rd,SignoExtendido,SignoShift)
begin
    case AluSelB is
        when "00" => b <= data2_rd;
        when "01" => b <= X"00000004";
        when "10" => b <= SignoExtendido;
        when "11" => b <= SignoShift;
        when others => b <= data2_rd;
    end case;
end process;

-- Alu Control -- 
 process (instR(5 downto 0), AluOp)
 begin
      case AluOp is
        when "10" =>
             case (instR(5 downto 0)) is 
                 when "100000"=>  --ADD                  
                       op <= "010";   
                 when "100010" => --SUB
                       op <= "110";
                 when "100100" => -- AND
                       op <= "000";
                 when "100101" => -- OR
                       op <= "001";
                 when "101010" => -- SLT
                       op <= "111";
                 when others => 
                       op <= "000";
             end case;
             when "01" =>  --BEQ
                 op <= "110";
             when "00" =>  -- MEM
                 op <= "010";
             when others =>  
                 op <= "000"; 
     end case;   
 end process;
 
 DataOut <= data2_rd;               
                
end Multicycle_MIPS_arch;