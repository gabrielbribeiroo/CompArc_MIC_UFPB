XOR:
    H = TOS                 ; Load top of stack (A) into H
    MAR = H; rd             ; Read the value from memory
    PC = PC + 1             ; Increment PC
    OPC = MDR               ; Store operand A in OPC
    
    H = SP - 1              ; Get second operand (B) from SP-1
    MAR = H; rd             ; Read the value from memory
    PC = PC + 1             ; Increment PC
    H = MDR                 ; Store operand B in H
    
    H = OPC OR H            ; Compute (A OR B)
    AC = H                  ; Save (A OR B) in AC
    H = OPC AND H           ; Compute (A AND B)
    H = NOT H               ; Compute NOT (A AND B)
    AC = AC AND H           ; Compute (A OR B) AND (NOT (A AND B)), result is A XOR B
    
    H = SP - 1              ; Get SP-1 to store result
    MAR = H                 ; Prepare to write result
    MDR = AC; wr            ; Write XOR result to memory
    SP = SP - 1             ; Adjust stack pointer
    PC = PC + 1             ; Move to the next instruction
