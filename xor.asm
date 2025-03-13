XOR:
    MAR <- SP, RD            ; Load first operand (A) from the stack
    H <- MDR                 ; Store operand A in register H
    MAR <- SP + 1, RD        ; Load second operand (B)
    OPC <- MDR               ; Store operand B in OPC

    H <- H OR OPC            ; Compute (A OR B), store in H
    AC <- H                  ; Save (A OR B) in AC
    H <- MDR AND OPC         ; Compute (A AND B)
    H <- NOT H               ; Compute NOT (A AND B)
    MDR <- AC AND H          ; Compute (A OR B) AND (NOT (A AND B)), result is A XOR B

    MAR <- SP, WR            ; Store the XOR result back at the top of the stack
    PC <- PC + 1, FETCH      ; Fetch the next instruction
