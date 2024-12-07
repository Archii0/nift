flags=-O2 -Wall -std=c++11
ldflags=

.PHONY: all clean

all: clean PROJECTNAME

PROJECTNAME: PROJECTNAME.o
	nvcc $(flags) $^ -o $@ $(ldflags)


PROJECTNAME.o: PROJECTNAME.cu
	nvcc $(flags) -c $<


clean:
	rm -f *.o PROJECTNAME