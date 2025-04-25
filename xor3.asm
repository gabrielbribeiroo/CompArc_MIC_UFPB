XOR:
    OPC = TOS                  ; Load operand A from the top of the stack
    SP = SP - 1                ; Move SP to point to operand B
    MAR = SP; RD               ; Read operand B into MDR
    AC = NOT OPC AND MDR       ; Compute (NOT A AND B)
    H = OPC AND NOT MDR        ; Compute (A AND NOT B)
    MDR = AC OR H              ; Compute (NOT A AND B) OR (A AND NOT B) = A XOR B

    MAR = SP                   ; Set memory address to current SP (where B was)
    WR                         ; Write result (A XOR B) into memory
    GOTO Main1                 ; Return to the main program