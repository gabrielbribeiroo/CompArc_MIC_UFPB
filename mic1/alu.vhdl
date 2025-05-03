-- Inclusion of standard IEEE libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- Digital signal types (std_logic, std_logic_vector)
use IEEE.NUMERIC_STD.ALL;       -- Arithmetic operations with unsigned/signed

-- Definition of the ALU (Arithmetic Logic Unit) entity
entity alu is
    port (
        A      : in  STD_LOGIC_VECTOR(15 downto 0);  -- Operand A (16-bit input)
        B      : in  STD_LOGIC_VECTOR(15 downto 0);  -- Operand B (16-bit input)
        S      : in  STD_LOGIC_VECTOR(5 downto 0);   -- Operation selector (6 bits)
        RESULT : out STD_LOGIC_VECTOR(15 downto 0)   -- Operation result (16 bits)
    );
end alu;

-- ALU architecture: behavioral style
architecture Behavioral of alu is
    signal tmp : STD_LOGIC_VECTOR(15 downto 0);  -- Internal signal to store the temporary result
begin

    -- Process sensitive to inputs A, B, and S
    process(A, B, S)
    begin
        -- Operation selection based on selector S
        case S is
            when "000000" => tmp <= A;                                              -- Pass A directly
            when "000001" => tmp <= B;                                              -- Pass B directly
            when "000010" => tmp <= std_logic_vector(unsigned(A) + unsigned(B));   -- Addition (A + B)
            when "000011" => tmp <= std_logic_vector(unsigned(A) - unsigned(B));   -- Subtraction (A - B)
            when "000100" => tmp <= A and B;                                        -- Bitwise AND operation
            when "000101" => tmp <= A or B;                                         -- Bitwise OR operation
            when "000110" => tmp <= not A;                                          -- Bitwise negation of A
            when "000111" => tmp <= not B;                                          -- Bitwise negation of B
            when "001000" => tmp <= A xor B;                                        -- Bitwise XOR operation
            when "001001" => tmp <= A nand B;                                       -- Bitwise NAND operation
            when "001010" => tmp <= A nor B;                                        -- Bitwise NOR operation
            when "001011" => tmp <= A xnor B;                                       -- Bitwise XNOR operation
            when others   => tmp <= (others => '0');                                -- Default case: return 0
        end case;
    end process;

    -- Assign the calculated value to the output signal RESULT
    RESULT <= tmp;
end Behavioral;