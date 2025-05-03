-- ============================================================================
-- Entity: mic1
-- ----------------------------------------------------------------------------
-- Description:
-- This is a structural VHDL design for a simple microprocessor unit (mic1).
-- It integrates a register bank and an ALU (Arithmetic Logic Unit) to perform
-- operations based on input signals and control logic.
--
-- Ports:
-- - clk    : Input clock signal for synchronization.
-- - we     : Write enable signal for the register bank.
-- - ra1    : Address of the first register to read from.
-- - ra2    : Address of the second register to read from.
-- - wa     : Address of the register to write to.
-- - wd     : Data to be written to the register bank.
-- - S      : Control signal for the ALU to determine the operation to perform.
-- - RESULT : Output signal carrying the result of the ALU operation.
--
-- Architecture: Structural
-- ----------------------------------------------------------------------------
-- Components:
-- 1. registers:
--    - A register bank that stores and retrieves data based on input addresses
--      and control signals.
--    - Inputs: clk, we, ra1, ra2, wa, wd
--    - Outputs: rd1, rd2
--
-- 2. alu:
--    - An Arithmetic Logic Unit that performs operations on two input operands
--      based on the control signal (S).
--    - Inputs: A, B, S
--    - Outputs: RESULT
--
-- Signal Descriptions:
-- - rd1, rd2 : Signals carrying data read from the register bank.
-- - alu_out  : Signal carrying the result of the ALU operation.
--
-- Design Flow:
-- 1. The register bank (REG_BANK) reads data from the specified registers
--    (ra1, ra2) and outputs them as rd1 and rd2.
-- 2. The ALU (ULA_INST) takes rd1 and rd2 as inputs, performs the operation
--    specified by the control signal (S), and outputs the result to alu_out.
-- 3. The final result (alu_out) is assigned to the RESULT output port.
-- ============================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mic1 is
    port (
        clk    : in  STD_LOGIC;
        we     : in  STD_LOGIC;
        ra1    : in  STD_LOGIC_VECTOR(3 downto 0);
        ra2    : in  STD_LOGIC_VECTOR(3 downto 0);
        wa     : in  STD_LOGIC_VECTOR(3 downto 0);
        wd     : in  STD_LOGIC_VECTOR(15 downto 0);
        S      : in  STD_LOGIC_VECTOR(5 downto 0);
        RESULT : out STD_LOGIC_VECTOR(15 downto 0)
    );
end mic1;

architecture Structural of mic1 is

    signal rd1, rd2  : STD_LOGIC_VECTOR(15 downto 0);
    signal alu_out  : STD_LOGIC_VECTOR(15 downto 0);

    component registers
        port (
            clk  : in  STD_LOGIC;
            we   : in  STD_LOGIC;
            ra1  : in  STD_LOGIC_VECTOR(3 downto 0);
            ra2  : in  STD_LOGIC_VECTOR(3 downto 0);
            wa   : in  STD_LOGIC_VECTOR(3 downto 0);
            wd   : in  STD_LOGIC_VECTOR(15 downto 0);
            rd1  : out STD_LOGIC_VECTOR(15 downto 0);
            rd2  : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    component alu
        port (
            A      : in  STD_LOGIC_VECTOR(15 downto 0);
            B      : in  STD_LOGIC_VECTOR(15 downto 0);
            S      : in  STD_LOGIC_VECTOR(5 downto 0);
            RESULT : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

begin

    REG_BANK: registers
        port map (
            clk  => clk,
            we   => we,
            ra1  => ra1,
            ra2  => ra2,
            wa   => wa,
            wd   => wd,
            rd1  => rd1,
            rd2  => rd2
        );

    ULA_INST: alu
        port map (
            A      => rd1,
            B      => rd2,
            S      => S,
            RESULT => alu_out
        );

    RESULT <= alu_out;

end Structural;