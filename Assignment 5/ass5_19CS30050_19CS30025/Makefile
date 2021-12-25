a.out: lex.yy.o y.tab.o ass5_19CS30050_19CS30025_translator.o
	g++ lex.yy.o y.tab.o ass5_19CS30050_19CS30025_translator.o -lfl

ass5_19CS30050_19CS30025_translator.o: ass5_19CS30050_19CS30025_translator.cxx ass5_19CS30050_19CS30025_translator.h
	g++ -c ass5_19CS30050_19CS30025_translator.h
	g++ -c ass5_19CS30050_19CS30025_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: ass5_19CS30050_19CS30025.l y.tab.h ass5_19CS30050_19CS30025_translator.h
	flex ass5_19CS30050_19CS30025.l

y.tab.c: ass5_19CS30050_19CS30025.y
	yacc -dtv ass5_19CS30050_19CS30025.y -W

y.tab.h: ass5_19CS30050_19CS30025.y
	yacc -dtv ass5_19CS30050_19CS30025.y -W

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass5_19CS30050_19CS30025_translator.o y.output a.out ass5_19CS30050_19CS30025_translator.h.gch ass5_19CS30050_19CS30025_quads.out ass5_19CS30050_19CS30025_quads1.out ass5_19CS30050_19CS30025_quads2.out ass5_19CS30050_19CS30025_quads3.out ass5_19CS30050_19CS30025_quads4.out ass5_19CS30050_19CS30025_quads5.out ass5_19CS30050_19CS30025_quads6.out ass5_19CS30050_19CS30025_quads7.out ass5_19CS30050_19CS30025_quads8.out ass5_19CS30050_19CS30025_quads9.out



test: 
	./a.out < ass5_19CS30050_19CS30025_test.c > ass5_19CS30050_19CS30025_quads.out
test1: 
	./a.out < ass5_19CS30050_19CS30025_test1.c > ass5_19CS30050_19CS30025_quads1.out
test2: 
	./a.out < ass5_19CS30050_19CS30025_test2.c > ass5_19CS30050_19CS30025_quads2.out
test3: 
	./a.out < ass5_19CS30050_19CS30025_test3.c > ass5_19CS30050_19CS30025_quads3.out
test4: 
	./a.out < ass5_19CS30050_19CS30025_test4.c > ass5_19CS30050_19CS30025_quads4.out
test5: 
	./a.out < ass5_19CS30050_19CS30025_test5.c > ass5_19CS30050_19CS30025_quads5.out
test6: 
	./a.out < ass5_19CS30050_19CS30025_test6.c > ass5_19CS30050_19CS30025_quads6.out
test7: 
	./a.out < ass5_19CS30050_19CS30025_test7.c > ass5_19CS30050_19CS30025_quads7.out
test8: 
	./a.out < ass5_19CS30050_19CS30025_test8.c > ass5_19CS30050_19CS30025_quads8.out
test9: 
	./a.out < ass5_19CS30050_19CS30025_test9.c > ass5_19CS30050_19CS30025_quads9.out
