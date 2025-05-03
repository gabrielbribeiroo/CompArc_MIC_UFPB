-- Inclusion of standard IEEE libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- Digital signal types
use IEEE.NUMERIC_STD.ALL;       -- Operations with unsigned/signed types

-- Testbench entity (no ports, as it is a simulation environment)
entity mic1_tb is
end entity;

-- Testbench architecture, called "sim"
architecture sim of mic1_tb is

    -- Declaration of signals to be connected to the DUT (Device Under Test)
    signal clk_sig     : std_logic := '0';                               -- Clock signal
    signal btn_we_sig  : std_logic := '0';                               -- Write enable signal
    signal sel_op_sig  : std_logic_vector(5 downto 0) := (others => '0');-- ALU operation code
    signal addr_ra_sig : std_logic_vector(3 downto 0) := (others => '0');-- Address of register A
    signal addr_rb_sig : std_logic_vector(3 downto 0) := (others => '0');-- Address of register B
    signal addr_wa_sig : std_logic_vector(3 downto 0) := (others => '0');-- Address of write register
    signal data_in_sig : std_logic_vector(15 downto 0) := (others => '0');-- Value to be written
    signal result_sig  : std_logic_vector(15 downto 0);                  -- ALU output

begin

    -- Instantiate the DUT (mic1_top) and connect the signals
    uut: entity work.mic1_top
        port map (
            clk     => clk_sig,
            btn_we  => btn_we_sig,
            sel_op  => sel_op_sig,
            addr_ra => addr_ra_sig,
            addr_rb => addr_rb_sig,
            addr_wa => addr_wa_sig,
            data_in => data_in_sig,
            result  => result_sig
        );

    -- Process that generates the clock: alternates between '0' and '1' every 5 ns (10 ns period)
    clk_proc: process
    begin
        while true loop
            clk_sig <= '0'; wait for 5 ns;
            clk_sig <= '1'; wait for 5 ns;
        end loop;
    end process;

    -- Process that applies stimuli and prints the results
    stim_proc: process
    begin
        ----------------------------------------------------------------
        -- 1) Write the value 5 to register R0
        btn_we_sig  <= '1';
        addr_wa_sig <= "0000";         -- address of R0
        data_in_sig <= x"0005";        -- value 5
        wait for 10 ns;
        report "Result after writing to R0 = "
                     & integer'image(to_integer(unsigned(result_sig))) severity note;
        btn_we_sig  <= '0';            -- disable write
        wait for 10 ns;

        ----------------------------------------------------------------
        -- 2) Write the value 3 to register R1
        btn_we_sig  <= '1';
        addr_wa_sig <= "0001";         -- address of R1
        data_in_sig <= x"0003";        -- value 3
        wait for 10 ns;
        report "Result after writing to R1 = "
                     & integer'image(to_integer(unsigned(result_sig))) severity note;
        btn_we_sig  <= '0';
        wait for 10 ns;

        -- ALU operations with R0 = 5 and R1 = 3
        ----------------------------------------------------------------
        -- ADD (5 + 3 = 8)
        addr_ra_sig <= "0000"; addr_rb_sig <= "0001";
        sel_op_sig  <= "000010";  -- operation code ADD
        wait for 20 ns;
        report "Result ADD = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        ----------------------------------------------------------------
        -- SUB (3 - 5 = -2 → 65534 in 16-bit unsigned representation)
        addr_ra_sig <= "0001"; addr_rb_sig <= "0000";
        sel_op_sig  <= "000011";  -- operation code SUB
        wait for 20 ns;
        report "Result SUB = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        ----------------------------------------------------------------
        -- AND (5 AND 3 = 1)
        sel_op_sig  <= "000100";  -- operation code AND
        wait for 20 ns;
        report "Result AND = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        ----------------------------------------------------------------
        -- OR (5 OR 3 = 7)
        sel_op_sig  <= "000101";  -- operation code OR
        wait for 20 ns;
        report "Result OR = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        ----------------------------------------------------------------
        -- NOT A (NOT 5 = 1111 1111 1111 1010 = 65530)
        addr_ra_sig <= "0000";     -- uses only A (R0)
        sel_op_sig  <= "000110";  -- operation code NOT A
        wait for 20 ns;
        report "Result NOT = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        ----------------------------------------------------------------
        -- XOR (5 XOR 3 = 6)
        addr_ra_sig <= "0000"; addr_rb_sig <= "0001";
        sel_op_sig  <= "001000";  -- operation code XOR
        wait for 20 ns;
        report "Result XOR = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        ----------------------------------------------------------------
        -- NAND (NOT(5 AND 3) = NOT(1) = 1111 1111 1111 1110 = 65534)
        sel_op_sig  <= "001001";  -- operation code NAND
        wait for 20 ns;
        report "Result NAND = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        ----------------------------------------------------------------
        -- NOR (NOT(5 OR 3) = NOT(7) = 1111 1111 1111 1000 = 65528)
        sel_op_sig  <= "001010";  -- operation code NOR
        wait for 20 ns;
        report "Result NOR = " &
                     integer'image(to_integer(unsigned(result_sig))) severity note;

        -- End simulation (infinite wait)
        wait;
    end process;

end architecture;