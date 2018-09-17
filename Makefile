# Makefile

CPPFLAGS= -MMD -D_XOPEN_SOURCE=500
CFLAGS= -Wall -Wextra -std=c99 -O2
LDFLAGS=
LDLIBS=

PRE := $(wildcard *.c.m4)
SRC := ${PRE:.c.m4=.c}
OBJ= ${SRC:.c=.o}
DEP= ${SRC:.c=.d}
PRG= ${SRC:.c=}

M4= m4
M4FLAGS=
M4SCRIPTS= $(filter-out $(PRE),$(wildcard *.m4))

.INTERMEDIATE: ${SRC}
.PHONY: all clean debug

all: ${PRG}

debug: CFLAGS += -g -DDEBUG
debug: all

# Target to make .c.m4 files without writing intermediate .c files to disk
#${PRG}: ${M4SCRIPTS} ${PRE}
#	${M4} ${M4FLAGGS} $@.c.m4 | ${CC} -x c - ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} ${LDLIBS} -o $@

%: ${M4SCRIPTS} %.c.m4
	${M4} ${M4FLAGGS} $@.c.m4 | ${CC} -x c - ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} ${LDLIBS} -o $@

%.c: %.c.m4 ${M4SCRIPTS}
	${M4} ${M4FLAGS} $< > $*.c

string.m4: vec.m4

clean:
	rm -f ${SRC} ${OBJ} ${DEP} ${PRG}

-include ${DEP}
