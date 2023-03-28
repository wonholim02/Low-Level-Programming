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

AND R0, R0, #0 ; clear
AND R1, R1, #0 ; clear
LDR R1, R5, #4 ; R1 = a
AND R2, R2, #0 ; clear
LDR R2, R5, #5 ; R2 = b
NOT R2, R2 ; negation of b
ADD R2, R2, #1 ; negation of b

IF1
ADD R1, R1, R2 ; R1 = a - b
BRnz ELSE1 ; check condition
AND R0, R0, #0 ; R0 = 0
STR R0, R5, #3 ; return 0
BR TD1
ELSE1
AND R0, R0, #0 ; R0 = 0
ADD R0, R0, #1 ; R0 = 1
STR R0, R5, #3 ; return 1
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
AND R1, R1, #0 ; clear;
LDR R1, R5, #4 ; R1 = x
AND R2, R2, #0 ; clear;
LDR R2, R5, #5 ; R2 = y
NOT R1, R1 ; negation of x
ADD R1, R1, #1 ; negation of x
ADD R1, R1, R2 ; R1 = y - x = - x + y
BRp IFCONDITION ; when y > x

ADD R6, R6, #-2 ; get space
LDR R1, R5, #4 ; R1 = x
LDR R2, R5, #5 ; R2 = y

NOT R2, R2 ; negation of y
ADD R2, R2, #1 ; negation of y
ADD R3, R1, R2 ; R3 = x - y
STR R3, R6, #0 ; prarm x - y
LDR R0, R5, #5 ; R0 = y
STR R0, R6, #1 ; param y
JSR DIV
AND R0, R0, #0 ; clear;
LDR R0, R6, #0 ; store return val to R0
ADD R0, R0, #1 ; recover
ADD R6, R6, #3 ; recover

STR R0, R5, #3 ; save return val
BR TD2

IFCONDITION
AND R3, R3, #0 ; clear
STR R3, R5, #3 ; return 0
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

AND R1, R1, #0 ; clear
STR R1, R5, #0 ; int i = 0

WHILELOOP
LDR R1, R5, #0 ; R1 = i
AND R2, R2, #0 ; clear
LDR R2, R5, #5 ; R2 = length
NOT R2, R2 ; negation
ADD R2, R2, #1 ; negation R2 = - length
ADD R1, R1, R2 ; R1 = i - length
BRzp TD3

AND R1, R1, #0 ; clear
LDR R1, R5, #4 ; R1 = arr
AND R2, R2, #0 ; clear
LDR R2, R5, #0 ; R2 = i
ADD R1, R1, R2 ; R1 = address
LDR R1, R1, #0 ; R1 = arr[i]
STR R1, R5, #-1 ; first = arr[i]

LDR R1, R5, #4 ; R1 = arr
LDR R2, R5, #0 ; R2 = i
ADD R2, R2, #1 ; R2 = i + 1
ADD R1, R1, R2 ; R1 = address
LDR R1, R1, #0 ; R1 = arr[i + 1]
STR R1, R5, #-2 ; second = arr[i + 1]

ADD R6, R6, #-2 ; get space
LDR R1, R5, #-1 ; R1 = first
STR R1, R6, #0 ; param
LDR R1, R5, #-2 ; R1 = second
STR R1, R6, #1 ; param
JSR DIV
LDR R1, R6, #0 ; cover
ADD R6, R6, #3 ; cover
STR R1, R5, #-3 ; DIV(first, second)

ADD R6, R6, #-2 ; get space
LDR R1, R5, #-1 ; R1 = first
STR R1, R6, #0 ; param
LDR R1, R5, #-2 ; R1 = second
STR R1, R6, #1 ; param
JSR MAX
LDR R1, R6, #0 ; cover
ADD R6, R6, #3 ; cover
STR R1, R5, #-4 ; MAX(first, second)

AND R1, R1, #0 ; clear
LDR R1, R5, #0 ; R1 = i
AND R2, R2, #0 ; clear
LDR R2, R5, #-4 ; R2 = offset
ADD R1, R1, R2 ; R1 = i + offset

AND R2, R2, #0 ; clear
LDR R2, R5, #4 ; R2 = arr
ADD R1, R1, R2 ; R1 = address
LDR R2, R5, #-3 ; R2 = DIV
STR R2, R1, #0 ; arr[i + offset] = DIV

AND R1, R1, #0 ; clear
LDR R1, R5, #0 ; R1 = i
ADD R1, R1, #1 ; i++
ADD R1, R1, #1 ; i++
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