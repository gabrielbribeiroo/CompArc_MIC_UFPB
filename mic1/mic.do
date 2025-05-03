# Creates the working library
vlib work

# Compiles the VHDL files in dependency order
vcom registers.vhd   ;# Register bank
vcom alu.vhd         ;# Arithmetic Logic Unit (ALU)
vcom mic1_top.vhd    ;# Top module connecting ALU and registers
vcom mic1_tb.vhd     ;# Testbench

# Starts the testbench simulation
vsim work.mic1_tb

# Adds all signals to the simulation view
add wave -r *

# Runs the simulation for 200 nanoseconds
run 200 ns
