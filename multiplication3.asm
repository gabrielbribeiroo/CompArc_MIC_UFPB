MUL:    
    OPC = TOS                 ; Load the multiplier from the top of the stack
    SP = SP - 1               ; Decrement the stack pointer to access the multiplicand
    MAR = SP; RD              ; Read the multiplicand from memory into MDR
    H = 0                     ; Initialize the accumulator (partial result) to zero

MUL_CHECK:
    IF OPC == 0 THEN GOTO MUL_END ; If the multiplier is zero, skip the loop

MUL_LOOP:
    H = H + MDR               ; Add the multiplicand to the accumulator
    OPC = OPC - 1             ; Decrement the multiplier
    IF OPC == 0 THEN GOTO MUL_END ; If multiplier reaches zero, exit loop
    GOTO MUL_LOOP             ; Repeat the loop

MUL_END:
    MAR = SP                  ; Get the address where the result should be stored
    MDR = H; WR               ; Write the result to memory (overwriting the multiplicand)
    GOTO Main1                ; Return to the main program