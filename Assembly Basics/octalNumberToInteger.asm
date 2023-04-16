orig x3000
    LEA R0, OCTALSTRING
    LDR R7, R0, #0
    AND R0, R0, #0
    LD R0, LENGTH
    AND R1, R1, #0
    ADD R1, R1, #0 

WHILE1
    AND R3, R3, #0 ;
    ADD R3, R3, 3
    WHILE2 BRnz ENDWHILE2
        ADD R1, R1, R1
        ADD R3, R3, #-1
    BR WHILE2
    
    ENDWHILE2
        LDR R4, R7, #0
        LD R5, ASCI
        ADD R4, R4, R5
        ADD R1, R1, R4
        ADD R7, R7, #1
        ADD R0, R0, #-1
        BRp WHILE1

    STI R1, RESULTADDR
    HALT
    

ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    
    .stringz "2823"           
.end
