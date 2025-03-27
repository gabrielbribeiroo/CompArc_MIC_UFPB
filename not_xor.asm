NOT_XOR:
    H = TOS                ; Load the first operand (A) from the top of the stack
    MAR = H; rd            ; Read the value from memory into MDR
    PC = PC + 1;           ; Increment the program counter
    OPC = MDR              ; Store operand A in OPC
    H = SP - 1             ; Get the second operand (B) from SP - 1
    MAR = H; rd            ; Read operand B from memory
    PC = PC + 1;           ; Increment the program counter
    H = MDR                ; Store operand B in H

    H = OPC OR H           ; Compute (A OR B) and store it in H
    AC = H                 ; Store (A OR B) in AC
    H = OPC AND MDR        ; Compute (A AND B) and store it in H
    H = NOT H              ; Compute NOT (A AND B)
    MDR = AC AND H         ; Compute (A OR B) AND (NOT (A AND B)), which is A XOR B
    MDR = NOT MDR          ; Invert the XOR result to obtain NOT (A XOR B)

    H = SP                 ; Get the stack pointer position
    MAR = H                ; Set the memory address for storing the result
    MDR = MDR; wr          ; Write the NOT XOR result to memory
    Goto Main1             ; Return to the main program