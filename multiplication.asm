MUL:
    OPC = TOS                 ; Load the first operand (multiplicand) from the top of the stack
    SP = SP - 1               ; Update the stack pointer to point to the next value (multiplier)
    MAR = SP; RD              ; Read the second operand (multiplier) from memory
    H = MDR                   ; Store the multiplier in register H
    AC = 0                    ; Initialize the accumulator to 0 (this will store the result)

MUL_LOOP:
    OPC = OPC - 1             ; Decrement the multiplicand (used as a loop counter)
    If (OPC) < 0 goto END_MUL ; If multiplicand is less than 0, exit the loop
    MDR = MDR + H             ; Add multiplier to the result accumulator
    goto MUL_LOOP             ; Repeat the loop

END_MUL:
    TOS = MDR; WR             ; Write the final result (product) back to the top of the stack
    goto Main1                ; Return to the main program