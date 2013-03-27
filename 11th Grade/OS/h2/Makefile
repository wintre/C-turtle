all: wc
wc: wc.o wclib.o
	gcc wc.o wclib.o -o wc
wc.o: wc.c
	gcc -c wc.c
wclib.o: wclib.c
	gcc -c wclib.c
clean:
	rm -rf *.o wc
