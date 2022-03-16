. Main function
	JSUB	INIT
	JSUB	FIRST
	JSUB	TABLE

. Array initialize
INIT	LDX	#0
	LDA	#1
	LDS	#3
	LDT	#27
ALOOP	STA	ARR,	X
	ADD	#1
	ADDR	S,	X
	COMPR	X,	T
	JLT	ALOOP
	RSUB

. Print first row
FIRST	LDX	#0
PTD	TD	OUTDEV
	JEQ	PTD
	LDA	#32
	WD	OUTDEV
	WD	OUTDEV
	WD	OUTDEV
	WD	OUTDEV
PLOOP	LDA	ARR,	X
	ADD	#48
	WD	OUTDEV
	LDA	#32
	WD	OUTDEV
	WD	OUTDEV
	WD	OUTDEV
	ADDR	S,	X
	COMPR	X,	T
	JLT	PLOOP
	LDA	#10
	WD	OUTDEV
	RSUB

. Loop 1
TABLE	LDX	#0
LOOP1	LDA	ARR,	X
	STA	NUM1
	STX	TEMP
	J	LOOP2
L1RE	LDX	TEMP
	ADDR	S,	X
	COMPR	X,	T
	JLT	LOOP1
	RSUB

. Loop 2
LOOP2	LDX	#0
LP2	LDA	ARR,	X
	STA	NUM2
	LDA	NUM1
	MUL	NUM2
	J	WRITE
L2RE	ADDR	S,	X
	COMPR	X,	T
	JLT	LP2
	J	NL

. Write function
WRITE	TD	OUTDEV
	JEQ	WRITE
	STA	CH
	COMP	#10
	JLT	SMALL
	J	BIG
SMALL	LDA	#32
	WD	OUTDEV
	WD	OUTDEV
	WD	OUTDEV
	LDA	CH
	ADD	#48
	WD	OUTDEV
	J	L2RE
BIG	LDA	#32
	WD	OUTDEV
	WD	OUTDEV
	LDA	CH
	DIV	#10
	STA	TENS
	LDA	CH
	SUB	TENS
	STA	UNITS
	LDA	TENS
	ADD	#48
	WD	OUTDEV
	LDA	UNITS
	ADD	#48
	WD	OUTDEV
	J	L2RE

. New line
NL	TD	OUTDEV
	JEQ	NL
	LDA	#10
	WD	OUTDEV
	J	L1RE

. Define variable
ARR	RESW	9
OUTDEV	BYTE	X'F2'
CH	RESW	1
NUM1	RESW	1
NUM2	RESW	1
TEMP	RESW	1
TENS	RESW	1
UNITS	RESW	1