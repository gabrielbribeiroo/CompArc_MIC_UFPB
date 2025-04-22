IXOR1:  MAR = SP - 1; RD            ; Read the second operand (B) from stack (SP - 1)
        MDR = MBR                   ; Move the operand B from MBR to MDR

IXOR2:  H = NOT TOS AND MDR         ; Compute NOT A AND B  (A is at TOS)

IXOR3:  H = H OR (TOS AND NOT MDR)  ; Compute (NOT A AND B) OR (A AND NOT B)
                                    ; This is the logical formula for A XOR B

IXOR4:  MAR = SP - 1; WR            ; Set address to store the result at SP - 1
        MBR = H                     ; Move the XOR result into MBR
        SP = SP - 1                 ; Decrement stack pointer (pop one operand)
        GOTO Main1                  ; Return to the main program
