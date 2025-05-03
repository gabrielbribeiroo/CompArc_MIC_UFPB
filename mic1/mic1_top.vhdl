-- Inclusion of standard IEEE libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- Logical signal types
use IEEE.NUMERIC_STD.ALL;       -- Support for integer operations (signed/unsigned)

-- Declaration of the mic1_top entity
-- This entity represents the main system, integrating the ALU and the register bank
entity mic1_top is
    Port (
        clk     : in  STD_LOGIC;                          -- main system clock
        btn_we  : in  STD_LOGIC;                          -- write enable: activates writing to the register bank
        sel_op  : in  STD_LOGIC_VECTOR(5 downto 0);       -- ALU operation selector
        addr_ra : in  STD_LOGIC_VECTOR(3 downto 0);       -- address of register A (read)
        addr_rb : in  STD_LOGIC_VECTOR(3 downto 0);       -- address of register B (read)
        addr_wa : in  STD_LOGIC_VECTOR(3 downto 0);       -- address of the write register
        data_in : in  STD_LOGIC_VECTOR(15 downto 0);      -- input data (for writing)
        result  : out STD_LOGIC_VECTOR(15 downto 0)       -- final system output (operation result or written value)
    );
end mic1_top;

-- Main system architecture
architecture Behavioral of mic1_top is

    -- Internal signals for interconnection between components
    signal a_out     : STD_LOGIC_VECTOR(15 downto 0);     -- output of register A (rd1)
    signal b_out     : STD_LOGIC_VECTOR(15 downto 0);     -- output of register B (rd2)
    signal alu_res   : STD_LOGIC_VECTOR(15 downto 0);     -- ALU result

begin

    ------------------------------------------------------------------
    -- Register Bank Instance
    -- This instance accesses two registers for reading (ra1, ra2)
    -- and allows writing to a third register (wa) if `we = '1'`
    reg_inst: entity work.registers
        port map (
            clk  => clk,         -- clock
            we   => btn_we,      -- write control
            ra1  => addr_ra,     -- address for reading A
            ra2  => addr_rb,     -- address for reading B
            wa   => addr_wa,     -- address for writing
            wd   => data_in,     -- data to be written
            rd1  => a_out,       -- output of register A
            rd2  => b_out        -- output of register B
        );

    ------------------------------------------------------------------
    -- ALU Instance
    -- Executes the selected operation between operands A and B
    alu_inst: entity work.alu
        port map (
            A      => a_out,     -- operand A from register A
            B      => b_out,     -- operand B from register B
            S      => sel_op,    -- ALU operation selector
            RESULT => alu_res    -- operation output
        );

    ------------------------------------------------------------------
    -- Output value selection:
    -- If the write button is activated (btn_we = '1'),
    -- the `result` output shows the data being written.
    -- Otherwise, the output is the ALU operation result.
    result <= data_in when btn_we = '1' else alu_res;

end Behavioral;