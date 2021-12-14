a.out: main.o libass2_19CS30050.a
	gcc main.o -L. -lass2_19CS30050
main.o: main.c myl.h
	gcc -Wall -c main.c
libass2_19CS30050.a: ass2_19CS30050.o
	ar -rcs libass2_19CS30050.a ass2_19CS30050.o
ass2_19CS30050.o: ass2_19CS30050.c myl.h
	gcc -Wall -c ass2_19CS30050.c
clean:
	rm a.out main.o libass2_19CS30050.a ass2_19CS30050.o