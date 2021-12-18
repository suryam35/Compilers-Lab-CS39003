
final: parser

parser: asgn4_19CS30050_19CS30025.c  y.tab.h lex.yy.c y.tab.c
	gcc asgn4_19CS30050_19CS30025.c lex.yy.c y.tab.c

lex.yy.c: asgn4_19CS30050_19CS30025.l y.tab.h
	flex asgn4_19CS30050_19CS30025.l y.tab.h

y.tab.h: asgn4_19CS30050_19CS30025.y
	yacc -d -t asgn4_19CS30050_19CS30025.y

test: a.out asgn4_19CS30050_19CS30025_test.c
	./a.out < asgn4_19CS30050_19CS30025_test.c

clean:
	rm a.out lex.yy.c y.tab.c y.tab.h

