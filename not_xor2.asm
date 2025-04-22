EXOR1:  MAR = SP - 1; RD           ; Read the second operand (B) from the stack at SP - 1
        MDR = MBR                  ; Move the memory buffer register value to MDR (value of B)

EXOR2:  H = NOT TOS AND NOT MDR    ; Compute (NOT A) AND (NOT B)

EXOR3:  H = H OR (TOS AND MDR)     ; Compute [(NOT A ∧ NOT B) ∨ (A ∧ B)] 
                                   ; This is the logical expression for A XNOR B (NOT XOR)

EXOR4:  MAR = SP - 1; WR           ; Set address SP - 1 to store the result
        MBR = H                    ; Move the result (XNOR) into the memory buffer register
        SP = SP - 1                ; Update the stack pointer, removing the top element (A)
        GOTO Main1                 ; Return to the main program
