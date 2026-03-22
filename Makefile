CC = clang
CFLAGS = -c -Wall -Wextra -O0
X86FLAGS = -target x86_64
ARMFLAGS = -target arm64
AFLAGS = -c -S -Wall -Wextra -fno-verbose-asm
LFLAGS = -Wall -Wextra
DEPS = gcd.h

all: main gcd0-arm.s gcd1-arm.s gcd2-arm.s gcd0-x86.s gcd1-x86.s gcd2-x86.s gcd3-x86.s
clean:
	rm -f *.o main gcd0.s gcd1.s gcd2.s gcd3.s gcd0-x86.s gcd1-x86.s gcd2-x86.s gcd3-x86.s gcd0-arm.s gcd1-arm.s gcd2-arm.s gcd3-arm.s

main: main.o gcd.o $(DEPS)
	${CC} ${LFLAGS} main.o gcd.o -o main

main.o: main.c $(DEPS)
	${CC} ${CFLAGS} main.c -o main.o

gcd.o: gcd.c $(DEPS)
	${CC} ${CFLAGS} gcd.c -o gcd.o

gcd0.s: gcd.c $(DEPS)
	${CC} ${AFLAGS}   -O0 gcd.c -o gcd0.s

gcd1.s: gcd.c $(DEPS)
	${CC} ${AFLAGS}   -O1 gcd.c -o gcd1.s

gcd2.s: gcd.c $(DEPS)
	${CC} ${AFLAGS}   -O2 gcd.c -o gcd2.s

gcd3.s: gcd.c $(DEPS)
	${CC} ${AFLAGS}   -O3 gcd.c -o gcd3.s

gcd0-x86.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} ${X86FLAGS}  -O0 gcd.c -o gcd0-x86.s

gcd1-x86.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} ${X86FLAGS}  -O1 gcd.c -o gcd1-x86.s

gcd2-x86.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} ${X86FLAGS}  -O2 gcd.c -o gcd2-x86.s

gcd3-x86.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} ${X86FLAGS}  -O3 gcd.c -o gcd3-x86.s

gcd0-arm.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} -O0 ${ARMFLAGS} gcd.c -o gcd0-arm.s

gcd1-arm.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} -O1 ${ARMFLAGS} gcd.c -o gcd1-arm.s

gcd2-arm.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} -O2 ${ARMFLAGS} gcd.c -o gcd2-arm.s

gcd3-arm.s: gcd.c $(DEPS)
	${CC} ${AFLAGS} -O3 ${ARMFLAGS} gcd.c -o gcd3-arm.s

