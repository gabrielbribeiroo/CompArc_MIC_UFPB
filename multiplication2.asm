MUL1:   OPC = TOS              ; Load the first operand (multiplier) from the top of the stack
        H = 0                  ; Initialize accumulator to 0

MUL2:   MAR = SP - 1; RD       ; Read the second operand (multiplicand) from memory

MUL3:   IF OPC == 0 THEN GOTO MUL_END  ; If the multiplier is 0, skip the loop

MUL4:   H = H + MDR            ; Add multiplicand to accumulator

MUL5:   OPC = OPC - 1          ; Decrement multiplier
        GOTO MUL2              ; Repeat the loop

MUL_END:
        MAR = SP - 1           ; Set memory address to store the result
        MDR = H; WR            ; Write the result to memory
        SP = SP - 1            ; Update the stack pointer
        GOTO Main1             ; Return to the main program