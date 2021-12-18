a.out:	lex.yy.c
		gcc lex.yy.c -lfl

lex.yy.c:	ass3_19CS30050_19CS30025.l ass3_19CS30050_19CS30025.c
		flex ass3_19CS30050_19CS30025.l ass3_19CS30050_19CS30025.c
        
clean:
		rm a.out lex.yy.c

test:
		./a.out <ass3_19CS30050_19CS30025_test.c
