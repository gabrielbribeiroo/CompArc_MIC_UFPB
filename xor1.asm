XOR:
    OPC = TOS                ; Load the first operand (A) from the top of the stack
    SP = SP - 1              ; Move the stack pointer to get the second operand (B)
    MAR = SP; RD             ; Read the second operand (B) from memory
    PC = PC + 1              ; Increment the program counter
    H = MDR                  ; Store the second operand (B) in H

    H = OPC OR H             ; Compute A OR B and store in H
    AC = H                   ; Save (A OR B) in AC
    H = OPC AND MDR          ; Compute A AND B and store in H
    H = NOT H                ; Compute NOT (A AND B)
    MDR = AC AND H           ; Compute (A OR B) AND (NOT (A AND B)) = A XOR B

    TOS = MDR; WR            ; Write the result back to the top of the stack
    goto Main1               ; Return to the main program