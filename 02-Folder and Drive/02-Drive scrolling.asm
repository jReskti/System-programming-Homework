INCLUDE E:/karshnasi/int8086.lib
MACRO SELDR
MOV CL,DH
SHR CL,1
MOV DL,CL
MOV AH,0EH
INT 21H
ENDM
.STACK 64
.DATA
A DB "A"
B DB "B"
C DB "C"
D DB "D"
E DB "E"
FF DB "F"
J DB "J"
F DB 26
;MSG DB "CHANGED DRIVE$"
.CODE
MAIN PROC FAR
MOV AX,@DATA
MOV DS,AX
mov AH,0Eh
INT 21h
MOV CX,7
MOV AL,"A"
MOV BL,0
RETURN:
SET_CUR BL,1
MOV DL,AL
SHOW_CHAR
INC AL
INC BL
INC BL
LOOP RETURN
MOV DH,0
SELDR DH
SET_CUR 0,0
SHOW_CHAR_MOD 16,0011B,1
; REC_SCR 0,7H,50H,45H,40H
FOR:
GET_ALL_CHAR
CMP AH,48H
JE UP
CMP AH,50H
JE DOWN
JMP FOR
UP:
GET_CUR_POS
CMP DH,0
JNE BOT
JMP UDLAST
BOT:
MOV DL," "
SHOW_CHAR
SUB DH,2
SELDR DH
SET_CUR DH,0
SHOW_CHAR_MOD 16,0011B,1
SET_CUR 20,20
JMP FOR
DOWN:
GET_CUR_POS
CMP DH,12
JNE TOP
JMP UDUP
TOP:
MOV DL," "
SHOW_CHAR
ADD DH,2
SELDR DH
SET_CUR DH,0
SHOW_CHAR_MOD 16,0011B,1
JMP FOR
UDLAST:
MOV DH,12
SELDR DH
MOV DL," "
SHOW_CHAR
SET_CUR DH,0
SHOW_CHAR_MOD 16,0011B,1
; REC_SCR 0,7H,50H,45H,10H
JMP FOR
UDUP:
MOV DH,0
SELDR DH
MOV DL," "
SHOW_CHAR
SET_CUR DH,0
SHOW_CHAR_MOD 16,0011B,1
; REC_SCR 0,7H,50H,45H,40H
JMP FOR
EXIT
MAIN ENDP