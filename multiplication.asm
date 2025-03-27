MUL:
    H = TOS                   ; Load first operand (multiplicand) from stack
    MAR = H; rd               ; Read multiplicand from memory
    PC = PC + 1               ; Increment PC
    OPC = MDR                 ; Store multiplicand in OPC

    H = SP - 1                ; Load second operand (multiplier) from SP-1
    MAR = H; rd               ; Read multiplier from memory
    PC = PC + 1               ; Increment PC
    H = MDR                   ; Store multiplier in H

    AC = 0                    ; Initialize accumulator to 0 (result)

MUL_LOOP:
    If (OPC) == 0 goto END_MUL ; If multiplier == 0, exit loop
    AC = AC + H               ; Add multiplicand to accumulator
    OPC = OPC - 1             ; Decrement multiplier
    goto MUL_LOOP             ; Repeat loop

END_MUL:
    H = SP                    ; Get stack pointer position
    MAR = H                   ; Set memory address for result storage
    MDR = AC; wr              ; Store multiplication result in memory
    SP = SP - 1               ; Update stack pointer
    goto Main1                ; Return to main program
