INCLUDE E:/karshnasi/int8086.lib
.STACK 64
.DATA
R DB "RED "$
G DB "GREEN "$
B DB "BLUE "$
F DB 26
.CODE
MAIN PROC FAR
MOV AX,@DATA
MOV DS,AX
SET_CUR 0,1
SHOW_STR R
SET_CUR 2,1
SHOW_STR G
SET_CUR 4,1
SHOW_STR B
SET_CUR 0,0
SHOW_CHAR_MOD 16,0011B,1
REC_SCR 0,7H,50H,45H,40H
FOR :
GET_ALL_CHAR
CMP AH,48H
JE UP
CMP AH,50H
JE DOWN
JMP FOR
UP:
GET_CUR_POS
CMP DH,0
JE UDLAST
CMP DH,2
JE UDUP
CMP DH,4
JE UDMID
DOWN:
GET_CUR_POS
CMP DH,0
JE UDMID
CMP DH,2
JE UDLAST
CMP DH,4
JE UDUP
UDLAST:
MOV DL" ",
SHOW_CHAR
SET_CUR 4,0
SHOW_CHAR_MOD 16,0011B,1
REC_SCR 0,7H,50H,45H,10H
JMP FOR
UDUP:
MOV DL" ",
SHOW_CHAR
SET_CUR 0,0
SHOW_CHAR_MOD 16,0011B,1
REC_SCR 0,7H,50H,45H,40H
JMP FOR
UDMID:
MOV DL" ",
SHOW_CHAR
SET_CUR 2,0
SHOW_CHAR_MOD 16,0011B,1
REC_SCR 0,7H,50H,45H,20H
JMP FOR
EXIT
MAIN ENDP