# Makefile
 
CC=gcc
CPPFLAGS= -MMD -D_XOPEN_SOURCE=500
CFLAGS= -Wall -Wextra -std=c99 -O2
LDFLAGS=
LDLIBS=

.SUFFIXES: .c.m4 .c
 
SRC= string.c result.c vec.c option.c
OBJ= ${SRC:.c=.o}
DEP= ${SRC:.c=.d}
PRG= ${SRC:.c=}

M4= m4
M4FLAGS=

%.c: %.c.m4
	${M4} ${M4FLAGS} $< > $*.c

all: ${PRG}
 
-include ${DEP}
 
clean:
	rm -f ${OBJ} ${DEP} ${PRG} ${SRC}
