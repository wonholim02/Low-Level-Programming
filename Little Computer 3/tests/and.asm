.orig x0000

AND R0, R0 0
ADD R0, R0, x000b

AND R1, R1, 0
ADD R1, R1, x000d

ADD R7, R7, xffff

AND R2, R0, R1
AND R3, R0, x000c

HALT

.end
