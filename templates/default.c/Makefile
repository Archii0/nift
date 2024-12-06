flags=-O2 -Wall -std=c2x
ldflags=

.PHONY: all clean

all: clean PROJECTNAME

PROJECTNAME: PROJECTNAME.o
	cc $(flags) $^ -o $@ $(ldflags)

PROJECTNAME.o: PROJECTNAME.c PROJECTNAME.h
	cc $(flags) -c $<

clean:
	rm -f *.o PROJECTNAME