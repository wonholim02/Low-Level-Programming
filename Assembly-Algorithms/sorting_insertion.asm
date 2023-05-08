.orig x3000
    HALT
    
INSERTION_SORT 
    ADD R6, R6, #-4
    STR R7, R6, #2  
    STR R5, R6, #1  
    ADD R5, R6, #0  
    ADD R6, R6, #-1 
    ADD R6, R6, #-5  
    STR R0, R5, #-2 
    STR R1, R5, #-3  
    STR R2, R5, #-4 
    STR R3, R5, #-5 
    STR R4, R5, #-6  

    AND R1, R1, #0 
    LDR R1, R5, #5 
    ADD R1, R1, #-1
    BRnz TEARDOWN 

    STR R1, R6, #1 
    LDR R1, R5, #4 
    STR R1, R6, #0 
    JSR INSERTION_SORT
    ADD R6, R6, #3

    LDR R1, R5, #5 
    ADD R1, R1, #-1 

    AND R2, R2, #0
    LDR R2, R5, #4 
    ADD R2, R2, R1 
    AND R0, R0, #0 
    LDR R0, R2, #0 
    STR R0, R5, #0 ]

    ADD R1, R1, #-1 
    STR R1, R5, #-1 

    WHILELOOP 
    LDR R1, R5, #-1
    BRn ENDWHILE
    LDR R2, R5, #4 
    ADD R2, R2, R1
    LDR R3, R2, #0
    LDR R0, R5, #0 
    
    NOT R0, R0
    ADD R0, R0, #1
    ADD R0, R3, R0    
    BRnz ENDWHILE

    STR R3, R2, #1
    ADD R1, R1, #-1
    STR R1, R5, #-1   
    BR WHILELOOP

    ENDWHILE
        LDR R1, R5, #-1
        LDR R2, R5, #4 
        ADD R2, R1, R2
        ADD R2, R2, #1 
        LDR R0, R5, #0 
        STR R0, R2, #0 

TEARDOWN 
 LDR R4, R5, #-6
 LDR R3, R5, #-5
 LDR R2, R5, #-4
 LDR R1, R5, #-3
 LDR R0, R5, #-2
 ADD R6, R5, #0
 LDR R7, R5, #2
 LDR R5, R5, #1
 ADD R6, R6, #3
RET

ADD R6, R6, #-4 
STR R7, R6, #2  
STR R5, R6, #1  
ADD R5, R6, #0  
ADD R6, R6, #-1 
ADD R6, R6, #-5  
STR R0, R5, #-2  
STR R1, R5, #-3  
STR R2, R5, #-4 
STR R3, R5, #-5 
STR R4, R5, #-6  

STACK .fill xF000
.end

.orig x4000	
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end
