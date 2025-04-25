NOT_XOR:
    OPC = TOS                  ; Load operand A from the top of the stack
    SP = SP - 1                ; Move stack pointer to point to operand B
    MAR = SP; RD               ; Read operand B from memory into MDR
    H = OPC AND MDR            ; Compute A AND B
    AC = NOT H                 ; Compute NOT (A AND B)

    H = OPC OR MDR             ; Compute A OR B
    H = AC AND H               ; Compute (NOT (A AND B)) AND (A OR B) = A XOR B
    MDR = NOT H                ; Compute NOT (A XOR B) = A XNOR B

    MAR = SP                   ; Set memory address to current SP (where B was)
    WR                         ; Write the result (A XNOR B) to memory
    goto Main1                 ; Return to the main program