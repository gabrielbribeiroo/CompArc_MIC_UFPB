NOT_XOR:
    MAR <- SP, RD            // Load first operand from the top of the stack
    H <- MDR                 // Store in register H
    MAR <- SP + 1, RD        // Load second operand
    MDR <- H XOR MDR         // Perform XOR between operands
    MDR <- NOT MDR           // Invert XOR result (negation)
    MAR <- SP, WR            // Store the result at the top of the stack
    PC <- PC + 1, FETCH      // Next instruction