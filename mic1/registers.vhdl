-- Standard IEEE Libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  -- Logical types (std_logic, std_logic_vector)
use IEEE.NUMERIC_STD.ALL;     -- Types and functions for numbers (signed/unsigned)

-- Entity that defines the register bank
entity registers is
    Port (
        clk   : in  STD_LOGIC;                        -- Clock to synchronize writing
        we    : in  STD_LOGIC;                        -- Write enable signal
        ra1   : in  STD_LOGIC_VECTOR(3 downto 0);     -- Address of the register for read port 1
        ra2   : in  STD_LOGIC_VECTOR(3 downto 0);     -- Address of the register for read port 2
        wa    : in  STD_LOGIC_VECTOR(3 downto 0);     -- Address of the register for writing
        wd    : in  STD_LOGIC_VECTOR(15 downto 0);    -- Data to be written
        rd1   : out STD_LOGIC_VECTOR(15 downto 0);    -- Data read from port 1
        rd2   : out STD_LOGIC_VECTOR(15 downto 0)     -- Data read from port 2
    );
end registers;

-- Architecture of the register bank
architecture Behavioral of registers is

    -- Define a vector of 16 registers, each 16 bits wide (0 to 15)
    type reg_array is array (15 downto 0) of STD_LOGIC_VECTOR(15 downto 0);

    -- Signal representing all registers; initialized to 0
    signal regs : reg_array := (others => (others => '0'));

begin
    -- Asynchronous read: data is read directly from the registers
    rd1 <= regs(to_integer(unsigned(ra1)));  -- converts ra1 address to index
    rd2 <= regs(to_integer(unsigned(ra2)));  -- converts ra2 address to index
     
    -- Synchronous write: data is written only on the rising edge of the clock
    process(clk)
    begin
        if rising_edge(clk) then            -- rising edge of the clock
            if we = '1' then                -- only if enabled
                regs(to_integer(unsigned(wa))) <= wd;  -- writes data to the register
            end if;
        end if;
    end process;

end Behavioral;