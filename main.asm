CS BIT P2.0
SCLK BIT P2.1
DOUT BIT P2.3

	ORG 00H
	MOV A,#38H 
	ACALL COMNWRT 
	ACALL DELAY 
	MOV A,#0CH 
	ACALL COMNWRT 
	ACALL DELAY 
	MOV A,#01 
	ACALL COMNWRT 
MAIN:
	SETB CS     
	CLR SCLK    
	SETB DOUT   

	CLR CS  
	SETB SCLK 
	ACALL DELAY
	CLR SCLK
	ACALL DELAY
	MOV R3,#8D

READ:
	SETB SCLK
	ACALL DELAY
	CLR SCLK
	ACALL DELAY
	MOV C,DOUT
	RLC A
	DJNZ R3,READ
	SETB CS
	MOV P1,A

	ACALL DELAY
	MOV A,#06H 
	ACALL COMNWRT
	ACALL DELAY 
	ACALL TEXT
	MOV A,#0C2H 
	ACALL COMNWRT
	ACALL DELAY 
	
	ACALL HEX2ASSCI
	MOV A,#'T'
	ACALL DATAWRT 
	MOV A,#'E'
	ACALL DATAWRT 
	MOV A,#'M'
	ACALL DATAWRT 
	MOV A,#'P'
	ACALL DATAWRT 
	MOV A,#':'
	ACALL DATAWRT 
	MOV A,#' '
	ACALL DATAWRT 
	MOV A,R5
	ACALL DATAWRT 
	MOV A,R6
	ACALL DATAWRT 
	MOV A,#'.'
	ACALL DATAWRT 
	MOV A,R4
	ACALL DATAWRT
	MOV A,#' '
	ACALL DATAWRT 
	MOV A,#'C'
	ACALL DATAWRT
	
	SJMP MAIN
	
	
TEXT :MOV A,#80H 
	ACALL COMNWRT 
	ACALL DELAY 
	MOV A,#'0'
	ACALL DATAWRT 
	MOV A,#'6'
	ACALL DATAWRT 
	MOV A,#'2'
	ACALL DATAWRT 
	MOV A,#'-'
	ACALL DATAWRT 
	MOV A,#'N'
	ACALL DATAWRT 
	MOV A,#'A'
	ACALL DATAWRT 
	MOV A,#'B'
	ACALL DATAWRT 
	MOV A,#'I'
	ACALL DATAWRT
	MOV A,#'L'
	ACALL DATAWRT 	
	MOV A,#'A'
	ACALL DATAWRT 
	RET
	

COMNWRT: 
	MOV P3,A 
	CLR P0.0 
	CLR P0.1 
	SETB P0.2 
	ACALL DELAY 
	CLR P0.2 
	RET

DATAWRT:
	MOV P3,A 
	SETB P0.0 
	CLR P0.1 
	SETB P0.2 
	ACALL DELAY 
	CLR P0.2 
	RET

HEX2ASSCI:
	MOV A,P1
	MOV B,#10D
	DIV AB
	ORL B,#30H
	MOV R6,B
	MOV B,#10D
	DIV AB
	ORL B,#30H
	MOV R5,B
	ORL A,#30H
	MOV R4,A
	RET

DELAY:	MOV R1,#50D
HERE2:	MOV R2,#250D
HERE:	DJNZ R2,HERE
	DJNZ R1,HERE2
	RET

END	
