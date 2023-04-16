.orig x3000
    LD R0, MOD
    LD R1, X
    NOT R0, R0
    ADD R0, R0, #1
    
WHILE
    ADD R2, R0, R1
    BRn ENDWHILE
    ADD R1, R1, R0
    BR WHILE

ENDWHILE
    ST R1, ANSWER
    HALT

    X      .fill 17
    MOD    .fill 5     
    ANSWER .blkw 1
.end 
