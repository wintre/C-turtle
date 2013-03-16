all: cat
cat: cat.o catlib.o
	gcc cat.o catlib.o -o cat
cat.o: cat.c
	gcc -c cat.c
catlib.o: catlib.c
	gcc -c catlib.c
clean:
	rm -rf *o cat
