NOT_XOR:
    MAR <- SP, RD            ; Load first operand from the top of the stack
    H <- MDR                 ; Store the first operand in register H
    MAR <- SP + 1, RD        ; Load second operand from the stack
    MDR <- H AND MDR         ; Perform AND between the operands
    MAR <- SP + 2, RD        ; Get OR operand
    MDR <- MDR OR H          ; Perform OR operation
    MDR <- NOT MDR           ; Invert the XOR result (negation)
    MAR <- SP, WR            ; Store the negated result back at the top of the stack
    PC <- PC + 1, FETCH      ; Fetch the next instruction