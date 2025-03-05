MUL:
    MAR <- SP, RD            // Load first operand (multiplicand)
    H <- MDR                 // Store in register H
    MAR <- SP + 1, RD        // Load second operand (multiplier)
    MDR <- MDR - 1           // Adjust iteration counter
    MAR <- SP, WR            // Zero the stack position to store the result
    MDR <- 0
    MAR <- SP, WR
MUL_LOOP:
    IF MDR < 0 THEN GOTO END_MUL  // If the multiplier is zero, end
    MAR <- SP, RD            // Get the accumulated value
    MDR <- MDR + H           // Add the multiplicand to the accumulator
    MAR <- SP, WR            // Store new accumulated value
    MAR <- SP + 1, RD        // Get multiplier
    MDR <- MDR - 1           // Decrement multiplier
    GOTO MUL_LOOP            // Repeat until the multiplier is zero
END_MUL:
    PC <- PC + 1, FETCH      // Next instruction