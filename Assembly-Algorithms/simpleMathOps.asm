.orig x3000
HALT

STACK .fill xF000
MAX
; BuildUp
ADD R6, R6, #-4
STR R7, R6, #2
STR R5, R6, #1
ADD R5, R6, #0
ADD R6, R6, #-10
STR  R0, R6, #4
STR  R1, R6, #3
STR  R2, R6, #2
STR  R3, R6, #1 
STR  R4, R6, #0 

AND R0, R0, #0
AND R1, R1, #0
LDR R1, R5, #4
AND R2, R2, #0
LDR R2, R5, #5 
NOT R2, R2
ADD R2, R2, #1

IF1
ADD R1, R1, R2
BRnz ELSE1
AND R0, R0, #0
STR R0, R5, #3
BR TD1
ELSE1
AND R0, R0, #0
ADD R0, R0, #1
STR R0, R5, #3
BR TD1

TD1
    LDR R4, R6, #0
    LDR R3, R6, #1
    LDR R2, R6, #2
    LDR R1, R6, #3
    LDR R0, R6, #4
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
    RET

DIV
; buildUp
ADD R6, R6, #-4
STR R7, R6, #2
STR R5, R6, #1
ADD R5, R6, #0
ADD R6, R6, #-10
STR  R0, R6, #4
STR  R1, R6, #3
STR  R2, R6, #2
STR  R3, R6, #1
STR  R4, R6, #0

IF2
AND R1, R1, #0
LDR R1, R5, #4
AND R2, R2, #0
LDR R2, R5, #5
NOT R1, R1
ADD R1, R1, #1
ADD R1, R1, R2
BRp IFCONDITION

ADD R6, R6, #-2
LDR R1, R5, #4
LDR R2, R5, #5

NOT R2, R2
ADD R2, R2, #1
ADD R3, R1, R2
STR R3, R6, #0
LDR R0, R5, #5
STR R0, R6, #1
JSR DIV
AND R0, R0, #0
LDR R0, R6, #0
ADD R0, R0, #1
ADD R6, R6, #3

STR R0, R5, #3
BR TD2

IFCONDITION
AND R3, R3, #0
STR R3, R5, #3
BR TD2

TD2
    LDR R4, R6, #0
    LDR R3, R6, #1
    LDR R2, R6, #2
    LDR R1, R6, #3
    LDR R0, R6, #4
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
    RET

MAP
ADD R6, R6, #-4
STR R7, R6, #2
STR R5, R6, #1
ADD R5, R6, #0
ADD R6, R6, #-10
STR R0, R6, #4
STR R1, R6, #3
STR R2, R6, #2
STR R3, R6, #1
STR R4, R6, #0

AND R1, R1, #0
STR R1, R5, #0

WHILELOOP
LDR R1, R5, #0
AND R2, R2, #0
LDR R2, R5, #5
NOT R2, R2
ADD R2, R2, #1
ADD R1, R1, R2
BRzp TD3

AND R1, R1, #0
LDR R1, R5, #4
AND R2, R2, #0
LDR R2, R5, #0
ADD R1, R1, R2
LDR R1, R1, #0
STR R1, R5, #-1

LDR R1, R5, #4
LDR R2, R5, #0
ADD R2, R2, #1
ADD R1, R1, R2
LDR R1, R1, #0
STR R1, R5, #-2

ADD R6, R6, #-2
LDR R1, R5, #-1
STR R1, R6, #0
LDR R1, R5, #-2
STR R1, R6, #1
JSR DIV
LDR R1, R6, #0
ADD R6, R6, #3
STR R1, R5, #-3

ADD R6, R6, #-2
LDR R1, R5, #-1
STR R1, R6, #0
LDR R1, R5, #-2
STR R1, R6, #1
JSR MAX
LDR R1, R6, #0
ADD R6, R6, #3
STR R1, R5, #-4

AND R1, R1, #0
LDR R1, R5, #0
AND R2, R2, #0
LDR R2, R5, #-4
ADD R1, R1, R2

AND R2, R2, #0
LDR R2, R5, #4
ADD R1, R1, R2
LDR R2, R5, #-3
STR R2, R1, #0

AND R1, R1, #0
LDR R1, R5, #0
ADD R1, R1, #1
ADD R1, R1, #1
STR R1, R5, #0 
BRnzp WHILELOOP

TD3
    LDR R4, R6, #0
    LDR R3, R6, #1
    LDR R2, R6, #2
    LDR R1, R6, #3
    LDR R0, R6, #4
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
    RET

LENGTH .fill x12
ARRAY .fill x4000

.end
.orig x4000
.fill 12
.fill 3
.fill 5
.fill 7
.fill 16
.fill 2
.fill 5
.fill 5
.fill 25
.fill 7
.fill 48
.fill 60
.end
