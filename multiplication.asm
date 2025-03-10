MUL:
    MAR <- SP, RD            ; Load the first operand (multiplicand)
    H <- MDR                 ; Store it in register H
    MAR <- SP + 1, RD        ; Load the second operand (multiplier)
    MDR <- MDR               ; Ensure the multiplier is in MDR
    MAR <- SP + 1, WR        ; Save the multiplier back to the stack
    MDR <- 0                 ; Initialize the accumulator to 0
    MAR <- SP, WR            ; Store the accumulator in the stack

MUL_LOOP:
    MAR <- SP + 1, RD        ; Retrieve the multiplier
    IF MDR == 0 THEN GOTO END_MUL  ; If the multiplier is zero, exit loop
    MAR <- SP, RD            ; Retrieve the accumulated value
    MDR <- MDR + H           ; Add the multiplicand to the accumulator
    MAR <- SP, WR            ; Store the updated accumulated value
    MAR <- SP + 1, RD        ; Retrieve the multiplier again
    MDR <- MDR - 1           ; Decrease the multiplier by 1
    MAR <- SP + 1, WR        ; Store the updated multiplier back on the stack
    GOTO MUL_LOOP            ; Repeat until the multiplier reaches zero

END_MUL:
    PC <- PC + 1, FETCH      ; Move to the next instruction