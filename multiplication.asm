MUL:
    H = TOS                  ; Load the first operand (multiplicand) from the stack
    MAR = H; rd              ; Read the value from memory into MDR
    PC = PC + 1;             ; Increment program counter
    OPC = MDR                ; Store the multiplicand in OPC
    H = SP - 1               ; Load the second operand (multiplier) from SP-1
    MAR = H; rd              ; Read multiplier from memory
    PC = PC + 1;             ; Increment program counter
    H = MDR                  ; Store multiplier in H
    AC = 0                   ; Initialize accumulator to 0 (result)

LOOP:
    OPC = OPC - 1            ; Decrement multiplier
    If (OPC) < 0 goto End    ; If multiplier < 0, end loop
    AC = AC + H              ; Add multiplicand to accumulator
    goto LOOP                ; Repeat loop

END:
    H = SP                   ; Get stack pointer position
    MAR = H                  ; Set memory address for result storage
    MDR = AC; wr             ; Store multiplication result in memory
    SP = SP - 1              ; Update stack pointer
    goto Main1               ; Return to main program
