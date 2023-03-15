orig x3000
    LEA R0, OCTALSTRING
    LDR R7, R0, #0 ; R7 = OCTALSTRING
    AND R0, R0, #0 ;
    LD R0, LENGTH ; R0 = len
    AND R1, R1, #0 ; R1 = val = 0
    ADD R1, R1, #0 ;

WHILE1
    AND R3, R3, #0 ;
    ADD R3, R3, 3 ; R3 = leftShift = 3
    WHILE2 BRnz ENDWHILE2 ; ENDWHILE
        ADD R1, R1, R1 ; val += val;
        ADD R3, R3, #-1 ; leftShift--;
    BR WHILE2 ; WHILE
    
    ENDWHILE2
        LDR R4, R7, #0 ; digit = OCTALSTRING[i]
        LD R5, ASCII ;
        ADD R4, R4, R5 ; digit = OCTALSTRING[i] - 48;
        ADD R1, R1, R4 ; val += digits
        ADD R7, R7, #1 ; i++
        ADD R0, R0, #-1 ;
        BRp WHILE1 ;

    STI R1, RESULTADDR ;
    HALT
    

ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    
    .stringz "2110"           
.end
