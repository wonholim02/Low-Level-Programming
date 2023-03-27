MULTIPLY 
    ADD R6, R6, -4	;;saving
    STR R7, R6, 2 	
    STR R5, R6, 1 	
    ADD R5, R6, 0	
    ADD R6, R6, -5	
    STR R0, R5, -1
    STR R1, R5, -2
    STR R2, R5, -3
    STR R3, R5, -4
    STR R4, R5, -5

    AND R0, R0, 0 ; clear
    AND R1, R1, 0 ; clear
    LDR R0, R5, 4 ; R0 = A 
    LDR R1, R5, 5 ; R1 = B
    AND R3, R3, 0 ; R3 = ret

    FORSTART
    AND R2, R2, 0 ; clear
    FORLOOP
    NOT R4, R2
    ADD R4, R4, 1	; increment
    ADD R4, R4, R1	
    BRnz TEARDOWNMUL
    ADD R2, R2, 1	; increment
    ADD R3, R3, R0	
    BR FORLOOP

TEARDOWNMUL
LDR R0, R5, 0 	
STR R3, R5, 3  
LDR R4, R5, -5
LDR R3, R5, -4
LDR R2, R5, -3
LDR R1, R5, -2
LDR R0, R5, -1
ADD R6, R5, 0
LDR R5, R6, 1
LDR R7, R6, 2
ADD R6, R6, 3
RET

FACTORIAL 
    ADD R6, R6, -4	;;saving
    STR R7, R6, 2 	
    STR R5, R6, 1 	
    ADD R5, R6, 0
    ADD R6, R6, -5	
    STR R0, R5, -1
    STR R1, R5, -2
    STR R2, R5, -3
    STR R3, R5, -4
    STR R4, R5, -5

    LDR R0, R5, 4	;; R0 = n
    AND R1, R1, 0	; clear
    ADD R1, R1, 1	;; R1 = ret
    FORSTART2
    AND R2, R2, 0 ; clear
    ADD R2, R2, 2	; set R2 = 2
    FORLOOP2
    NOT R3, R2
    ADD R3, R3, 1	; incrment
    ADD R3, R3, R0	
    BRn ENDFOR

    ADD R6, R6, -2 ; for starting point 
    STR R1, R6, 0 ;arg
    STR R2, R6, 1 ;arg
    JSR MULTIPLY
    LDR R1, R6, 0 ; get return value
    ADD R6, R6, 3

    ADD R2, R2, 1	; i++
    BR FORLOOP2
    ENDFOR

    STR R1, R5, 3	; store return val

    LDR R0, R5, 0 	
    LDR R4, R5, -5
    LDR R3, R5, -4
    LDR R2, R5, -3
    LDR R1, R5, -2
    LDR R0, R5, -1
    ADD R6, R5, 0
    LDR R5, R6, 1
    LDR R7, R6, 2
    ADD R6, R6, 3
    RET
    
STACK .fill xF000
.end
