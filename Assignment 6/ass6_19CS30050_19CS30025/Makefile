compile: lex.yy.o y.tab.o ass6_19CS30050_19CS30025_translator.o ass6_19CS30050_19CS30025_target_traslator.o
	g++ lex.yy.o y.tab.o ass6_19CS30050_19CS30025_translator.o ass6_19CS30050_19CS30025_target_traslator.o -lfl -o compile
	# Enter 'make run' to generate Quad and Assembly Language File , then 'make test' to generate all output files 

ass6_19CS30050_19CS30025_target_traslator.o: ass6_19CS30050_19CS30025_target_traslator.cxx
	g++ -c  ass6_19CS30050_19CS30025_target_traslator.cxx

y.tab.o:	y.tab.c
	g++ -c y.tab.c

lex.yy.o:	lex.yy.c
	g++ -c lex.yy.c

lex.yy.c:	ass6_19CS30050_19CS30025.l y.tab.c
	flex ass6_19CS30050_19CS30025.l

y.tab.c:	ass6_19CS30050_19CS30025.y
	yacc --verbose -dtv ass6_19CS30050_19CS30025.y

ass6_19CS30050_19CS30025_translator.o: ass6_19CS30050_19CS30025_translator.h ass6_19CS30050_19CS30025_translator.cxx
	g++ -c ass6_19CS30050_19CS30025_translator.cxx

myl.o:	myl.c myl.h
	gcc -c myl.c

clean:
	rm ass6_19CS30050_19CS30025_target_traslator.o compile y.tab.o lex.yy.o lex.yy.c y.tab.c y.tab.h y.output ass6_19CS30050_19CS30025_translator.o libass2_19CS30050_19CS30025.a ass2_19CS30050_19CS30025.o quad_list1.out quad_list2.out quad_list3.out quad_list4.out quad_list5.out quad_list6.out quad_list7.out quad_list8.out quad_list9.out test1 test2 test3 test4 test5 test6 test7 test8 test9 ass6_19CS30050_19CS30025_test1.s ass6_19CS30050_19CS30025_test1.o ass6_19CS30050_19CS30025_test2.s ass6_19CS30050_19CS30025_test2.o ass6_19CS30050_19CS30025_test3.s ass6_19CS30050_19CS30025_test3.o ass6_19CS30050_19CS30025_test4.s ass6_19CS30050_19CS30025_test4.o ass6_19CS30050_19CS30025_test5.s ass6_19CS30050_19CS30025_test5.o ass6_19CS30050_19CS30025_test6.s ass6_19CS30050_19CS30025_test6.o ass6_19CS30050_19CS30025_test7.s ass6_19CS30050_19CS30025_test7.o ass6_19CS30050_19CS30025_test8.s ass6_19CS30050_19CS30025_test8.o ass6_19CS30050_19CS30025_test9.s ass6_19CS30050_19CS30025_test9.o

run:
	./compile 1 < ass6_19CS30050_19CS30025_test1.c > ass6_19CS30050_19CS30025_test1.s
	./compile 2 <  ass6_19CS30050_19CS30025_test2.c > ass6_19CS30050_19CS30025_test2.s
	./compile 3 < ass6_19CS30050_19CS30025_test3.c > ass6_19CS30050_19CS30025_test3.s
	./compile 4 < ass6_19CS30050_19CS30025_test4.c > ass6_19CS30050_19CS30025_test4.s
	./compile 5 < ass6_19CS30050_19CS30025_test5.c > ass6_19CS30050_19CS30025_test5.s
	./compile 6 < ass6_19CS30050_19CS30025_test6.c > ass6_19CS30050_19CS30025_test6.s
	./compile 7 < ass6_19CS30050_19CS30025_test7.c > ass6_19CS30050_19CS30025_test7.s
	./compile 8 < ass6_19CS30050_19CS30025_test8.c > ass6_19CS30050_19CS30025_test8.s
	./compile 9 < ass6_19CS30050_19CS30025_test9.c > ass6_19CS30050_19CS30025_test9.s

test: test1 test2 test3 test4 test5 test6 test7 test8 test9

test1: ass6_19CS30050_19CS30025_test1.o libass2_19CS30050_19CS30025.a
	gcc -no-pie ass6_19CS30050_19CS30025_test1.o -o test1 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test1.o: myl.h
	gcc  -c ass6_19CS30050_19CS30025_test1.s

test2: ass6_19CS30050_19CS30025_test2.o libass2_19CS30050_19CS30025.a
	gcc -no-pie  ass6_19CS30050_19CS30025_test2.o -o test2 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test2.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test2.s

test3: ass6_19CS30050_19CS30025_test3.o libass2_19CS30050_19CS30025.a
	gcc -no-pie ass6_19CS30050_19CS30025_test3.o -o test3 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test3.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test3.s

test4: ass6_19CS30050_19CS30025_test4.o libass2_19CS30050_19CS30025.a
	gcc -no-pie  ass6_19CS30050_19CS30025_test4.o -o test4 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test4.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test4.s

test5: ass6_19CS30050_19CS30025_test5.o libass2_19CS30050_19CS30025.a
	gcc -no-pie  ass6_19CS30050_19CS30025_test5.o -o test5 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test5.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test5.s

test6: ass6_19CS30050_19CS30025_test6.o libass2_19CS30050_19CS30025.a
	gcc -no-pie  ass6_19CS30050_19CS30025_test6.o -o test6 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test6.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test6.s

test7: ass6_19CS30050_19CS30025_test7.o libass2_19CS30050_19CS30025.a
	gcc -no-pie  ass6_19CS30050_19CS30025_test7.o -o test7 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test7.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test7.s

test8: ass6_19CS30050_19CS30025_test8.o libass2_19CS30050_19CS30025.a
	gcc -no-pie  ass6_19CS30050_19CS30025_test8.o -o test8 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test8.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test8.s

test9: ass6_19CS30050_19CS30025_test9.o libass2_19CS30050_19CS30025.a
	gcc -no-pie  ass6_19CS30050_19CS30025_test9.o -o test9 -L. -lass2_19CS30050_19CS30025
ass6_19CS30050_19CS30025_test9.o: myl.h
	gcc -Wall -c ass6_19CS30050_19CS30025_test9.s


libass2_19CS30050_19CS30025.a: ass2_19CS30050_19CS30025.o
	ar -rcs libass2_19CS30050_19CS30025.a ass2_19CS30050_19CS30025.o

ass2_19CS30050_19CS30025.o: myl.c myl.h
	gcc -Wall -c myl.c -o ass2_19CS30050_19CS30025.o


