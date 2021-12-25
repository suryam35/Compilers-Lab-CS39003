/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

%{ 
 	/* C Declarations and Definitions */
	#include <string.h>
	#include <stdio.h>
	#include "ass5_19CS30050_19CS30025_translator.h"
	extern	int yylex();
	void yyerror(const char *s);
	extern type_e TYPE;
	extern int gDebug;

	/* Iterator variable declaration */ 
	int i1_a,i2_a;

%}


%union {
	int intval;
	int instr;
	char* strval;
	float floatval;
	sym* symp;
	expr* exp;
	lint* nl;
	symtype* st;
	statement* stat;
	unary* A;
	char uop;	//unary operator
}

%token BREAK CASE CONTINUE DEFAULT DO IF ELSE FOR GOTO WHILE SWITCH SIZEOF TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTRICT STRUCT UNION ENUM CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID BOOL COMPLEX IMAGINARY RETURN ELLIPSIS RIGHT_ASSIGN LEFT_ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN RIGHT_OP LEFT_OP INC_OP DEC_OP PTR_OP AND_OP OR_OP LE_OP GE_OP EQ_OP NE_OP

%token <strval> STRING_LITERAL
%token <symp>IDENTIFIER  PUNCTUATORS COMMENT
%token <intval>INT_CONSTANT 
	
%token <strval> FLOAT_CONSTANT
	ENU_CONSTANT 
%token <char>CHAR_CONSTANT

%start translation_unit
   	
// Expressions
%type <exp>
	expression
	primary_expression 
	multiplicative_expression
	additive_expression
	shift_expression
	relational_expression
	equality_expression
	and_expression
	exclusive_or_expression
	inclusive_or_expression
	logical_and_expression
	logical_or_expression
	conditional_expression
	assignment_expression
	expression_statement


%type <instr> M
%type <exp> N
%type <st> pointer
%type <symp> direct_declarator init_declarator declarator
%type <intval> argument_expression_list
%type <uop> unary_operator
%type <symp> constant initializer



%type <stat>  statement
	labeled_statement 
	compound_statement
	
	selection_statement
	iteration_statement
	jump_statement
	block_item
	block_item_list


%type <A> postfix_expression
	unary_expression
	cast_expression

%%
primary_expression
	: IDENTIFIER {printf("primary_expression -> IDENTIFIER \n");
		$$ = new expr();
		i1_a = 0;
		$$->symp = $1;
		i1_a++;
		$$->isbool = false;i1_a++;
	}
	| constant {printf("primary_expression -> constant \n");
		$$ = new expr();i1_a++;
		$$->symp = $1;i1_a++;
	}
	| STRING_LITERAL {printf("primary_expression -> STRING_LITERAL \n");
		$$ = new expr();i1_a=0;
		$$->symp = gentemp(PTR, $1);i1_a++;
		$$->symp->initialize($1);i1_a++;
		$$->symp->type->ptr = new symtype(_CHAR);i1_a++;
	}
	| '(' expression ')' {printf("primary_expression -> '(' expression ')' \n");
		$$ = $2;i1_a=0;
	}
	;

constant
	: INT_CONSTANT {printf("constant -> INT_CONSTANT \n");
		$$ = gentemp(_INT, NumberToString($1));i1_a=0;
		emit(EQUAL, $$->name, $1);i1_a++;
	}
	| FLOAT_CONSTANT {printf("constant -> FLOAT_CONSTANT \n");
		$$ = gentemp(_FLOAT, *new string ($1));i1_a++;
		emit(EQUAL, $$->name, *new string($1));i1_a++;
	}
	| ENU_CONSTANT {printf("constant -> ENU_CONSTANT \n");	/* Ignored */
	}
	| CHAR_CONSTANT{printf("constant -> CHAR_CONSTANT \n");
		$$ = gentemp(_CHAR);i1_a=0;
		emit(EQUAL, $$->name, "a");i1_a++;
	}
	;


postfix_expression
	: primary_expression  {printf("postfix_expression -> primary_expression \n");
		$$ = new unary ();i1_a=0;
		$$->symp = $1->symp;i1_a++;
		$$->loc = $$->symp;i1_a++;
		$$->type = $1->symp->type;i1_a++;
	}
	| postfix_expression '[' expression ']' {printf("postfix_expression -> postfix_expression '[' expression ']' \n");
		$$ = new unary();i1_a=0;
		$$->symp = $1->symp;i1_a++;		// copy the base
		$$->type = $1->type->ptr;i1_a++;		// type = type of element
		$$->loc = gentemp(_INT);i1_a++;	// store computed address
		
		// New address = already computed + $3 * new width
		if ($1->cat==ARR) {		// if something already computed
			sym* t = gentemp(_INT);i1_a++;
 			emit(MULT, t->name, $3->symp->name, NumberToString(sizeoftype($$->type)));i1_a++;
			emit (ADD, $$->loc->name, $1->loc->name, t->name);i1_a++;
		}
 		else {
	 		emit(MULT, $$->loc->name, $3->symp->name, NumberToString(sizeoftype($$->type)));i1_a++;
 		}

 		// Mark that it contains array address and first time computation is done
		$$->cat = ARR;i1_a++;

	}
	| postfix_expression '(' ')' {printf("postfix_expression -> postfix_expression '(' ')'  \n");}
	| postfix_expression '(' argument_expression_list ')' {printf("postfix_expression ->  postfix_expression '(' argument_expression_list ')' \n");
		$$ = new unary();i2_a=0;
		$$->symp = gentemp($1->type->cat);i2_a++;
		emit(CALL, $$->symp->name, $1->symp->name, tostr($3));i2_a++;
	}
	| postfix_expression '.' IDENTIFIER /* Ignored */{printf("postfix_expression ->  postfix_expression '.' IDENTIFIER \n");}
	| postfix_expression PTR_OP IDENTIFIER  /* Ignored */{printf("postfix_expression -> postfix_expression PTR_OP IDENTIFIER \n");}
	| postfix_expression INC_OP {printf("postfix_expression -> postfix_expression INC_OP  \n");
		$$ = new unary();i2_a=0;

		// copy $1 to $$
		$$->symp = gentemp($1->symp->type->cat);i2_a++;
		emit (EQUAL, $$->symp->name, $1->symp->name);i2_a++;

		// Increment $1
		emit (ADD, $1->symp->name, $1->symp->name, "1");i2_a++;
	}
	| postfix_expression DEC_OP {printf("postfix_expression -> postfix_expression DEC_OP \n");
		$$ = new unary();i2_a=0;

		// copy $1 to $$
		$$->symp = gentemp($1->symp->type->cat);i2_a++;
		emit (EQUAL, $$->symp->name, $1->symp->name);i2_a++;

		// Decrement $1
		emit (SUB, $1->symp->name, $1->symp->name, "1");i2_a++;
	}
	| '(' type_name ')' '{' initializer_list '}' { /* Ignored */printf("postfix_expression -> '(' type_name ')' '{' initializer_list '}' \n");
		$$ = new unary();i2_a=0;
		$$->symp = gentemp(_INT, "0");i2_a++;
		$$->loc = gentemp(_INT, "0");i2_a++;
	}
	|  '(' type_name ')' '{' initializer_list ',' '}' { /* Ignored */printf("postfix_expression -> '(' type_name ')' '{' initializer_list ',' '}' \n");
		$$ = new unary();i2_a++;
		$$->symp = gentemp(_INT, "0");i2_a++;
		$$->loc = gentemp(_INT, "0");i2_a++;
	}
	;

argument_expression_list
	: assignment_expression {printf("argument_expression_list -> assignment_expression \n");
		emit (PARAM, $1->symp->name);i2_a=0;
		$$ = 1;i2_a++;
	}
	| argument_expression_list ',' assignment_expression {printf("argument_expression_list -> argument_expression_list ',' assignment_expression \n");
		emit (PARAM, $3->symp->name);i2_a++;
		$$ = $1+1;i2_a++;
	}
	;

unary_expression
	: postfix_expression {printf("unary_expression -> postfix_expression \n");
		$$ = $1;i2_a++;
	}
	| INC_OP unary_expression {printf("unary_expression -> INC_OP unary_expression \n");
		// Increment $1
		emit (ADD, $2->symp->name, $2->symp->name, "1");i2_a++;

		// Use the same value
		$$ = $2;i2_a++;
	}
	| DEC_OP unary_expression {printf("unary_expression -> DEC_OP unary_expression \n");
		// Decrement $1
		emit (SUB, $2->symp->name, $2->symp->name, "1");i2_a++;

		// Use the same value
		$$ = $2;i2_a++;
	}
	| unary_operator cast_expression {printf("unary_expression -> unary_operator cast_expression \n");
		$$ = new unary();i2_a++;
		switch ($1) {
			case '&':
				//cout<<"1"<<endl; 
				$$->symp = gentemp(PTR);i2_a++;
				$$->symp->type->ptr = $2->symp->type;
				emit (ADDRESS, $$->symp->name, $2->symp->name);i2_a++;
				break;
			case '*':
				debug ("got pointer");i2_a++;
				$$->cat = PTR;
				debug ($2->symp->name);i2_a++;
				$$->loc = gentemp ($2->symp->type->ptr);
				emit (PTRR, $$->loc->name, $2->symp->name);i2_a++;
				$$->symp = $2->symp;
				debug ("here pointer");i2_a++;
				break;
			case '+':
				$$ = $2;i2_a++;
				break;
			case '-':
				$$->symp = gentemp($2->symp->type->cat);
				emit (UMINUS, $$->symp->name, $2->symp->name);i2_a++;
				break;
			case '~':
				$$->symp = gentemp($2->symp->type->cat);
				emit (BNOT, $$->symp->name, $2->symp->name);i2_a++;
				break;
			case '!':
				$$->symp = gentemp($2->symp->type->cat);
				emit (LNOT, $$->symp->name, $2->symp->name);i2_a++;
				break;
			default:
				break;
		}
	}
	| SIZEOF unary_expression {	/* Ignored */printf("unary_expression -> SIZEOF unary_expression  \n");
		$$ = $2;i2_a++;
	}
	| SIZEOF '(' type_name ')' {	/* Ignored */printf("unary_expression -> SIZEOF '(' type_name ')' \n");
		$$->symp = gentemp(_INT, tostr(sizeoftype(new symtype (TYPE))));i2_a++;
	}
	;

unary_operator
	: '&' {
		$$ = '&';i2_a++;printf("unary_operator -> & \n");
	}
	| '*' {
		$$ = '*';i2_a++;printf("unary_operator -> * \n");
	}
	| '+' {
		$$ = '+';i2_a++;printf("unary_operator -> + \n");
	}
	| '-' {
		$$ = '-';i2_a++;printf("unary_operator ->  -\n");
	}
	| '~' {
		$$ = '-';i2_a++;printf("unary_operator ->  ~\n");
	}
	| '!' {
		$$ = '!';i2_a++;printf("unary_operator ->  ! \n");
	}
	;

cast_expression
	: unary_expression  {printf("cast_expression -> unary_expression\n");
		$$ = $1;i2_a++;
	}
	| '(' type_name ')' cast_expression  /* Ignored */
	{$$ = $4;i2_a++;printf("cast_expression -> ( type_name ) cast_expression \n");}
	;

multiplicative_expression
	: cast_expression {printf("multiplicative_expression -> cast_expression\n");
		// Now the cast expression can't go to LHS of assignment_expression
		// So we can safely store the rvalues of pointer and arrays in temporary
		// We don't need to carry lvalues anymore
		$$ = new expr();i2_a++;
		if ($1->cat==ARR) { // Array
			$$->symp = gentemp($1->loc->type);
			emit(ARRR, $$->symp->name, $1->symp->name, $1->loc->name);i2_a++;
		}
		else if ($1->cat==PTR) { // Pointer
			$$->symp = $1->loc;i2_a++;
		}
		else { // otherwise
			$$->symp = $1->symp;i2_a++;
		}
	}
	| multiplicative_expression '*' cast_expression {printf("multiplicative_expression -> multiplicative_expression * cast_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();i2_a++;
			$$->symp = gentemp (_INT);
			emit (MULT, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;
	}
	| multiplicative_expression '/' cast_expression{printf("multiplicative_expression -> multiplicative_expression / cast_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();i2_a++;
			$$->symp = gentemp (_INT);
			emit (DIVIDE, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;
	}
	| multiplicative_expression '%' cast_expression {printf("multiplicative_expression -> multiplicative_expression percent cast_expression \n");
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();i2_a++;
			$$->symp = gentemp (_INT);
			emit (MODOP, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	;

additive_expression
	: multiplicative_expression {$$ = $1;printf("additive_expression -> multiplicative_expression\n");}
	| additive_expression '+' multiplicative_expression {printf("additive_expression -> additive_expression '+' multiplicative_expression\n");
		if (typecheck($1->symp, $3->symp)) {
			$$ = new expr();i2_a++;
			$$->symp = gentemp(_INT);
			emit (ADD, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	| additive_expression '-' multiplicative_expression {printf("additive_expression -> additive_expression '-' multiplicative_expression \n");
		if (typecheck($1->symp, $3->symp)) {
			$$ = new expr();i2_a++;
			$$->symp = gentemp($1->symp->type->cat);
			emit (SUB, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;
	}
	;

shift_expression
	: additive_expression {$$ = $1;printf("shift_expression -> additive_expression\n");}
	| shift_expression LEFT_OP additive_expression {printf("shift_expression -> shift_expression LEFT_OP additive_expression\n");
		if ($3->symp->type->cat == _INT) {
			$$ = new expr();i2_a++;
			$$->symp = gentemp (_INT);
			emit (LEFTOP, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;
	}
	| shift_expression RIGHT_OP additive_expression {printf("shift_expression ->  shift_expression RIGHT_OP additive_expression\n");
		if ($3->symp->type->cat == _INT) {
			$$ = new expr();i2_a++;
			$$->symp = gentemp (_INT);
			emit (RIGHTOP, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	;

relational_expression
	: shift_expression { $$ = $1;printf("relational_expression -> shift_expression\n");}
	| relational_expression '<' shift_expression {printf("relational_expression -> relational_expression '<' shift_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();i2_a++;
			$$->isbool = true;
			$$->truelist = makelist (nextinstr());i2_a++;
			$$->falselist = makelist (nextinstr()+1);
			emit(LT, "", $1->symp->name, $3->symp->name);
			emit (GOTOOP, "");i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	| relational_expression '>' shift_expression {
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();i2_a++;
			$$->isbool = true;
			$$->truelist = makelist (nextinstr());i2_a++;
			$$->falselist = makelist (nextinstr()+1);
			emit(GT, "", $1->symp->name, $3->symp->name);
			emit (GOTOOP, "");i2_a++;
		}
		else cout << "Type Error"<< endl;printf("relational_expression -> relational_expression '>' shift_expression\n");
	}
	| relational_expression LE_OP shift_expression {printf("relational_expression -> relational_expression LE_OP shift_expressio\n");
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();i2_a++;
			$$->isbool = true;
			$$->truelist = makelist (nextinstr()); i2_a++;
			$$->falselist = makelist (nextinstr()+1);
			emit(LE, "", $1->symp->name, $3->symp->name);i2_a++;
			emit (GOTOOP, "");i2_a++;
		}
		else cout << "Type Error"<< endl;
	}
	| relational_expression GE_OP shift_expression {printf("relational_expression -> relational_expression GE_OP shift_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();i2_a++;
			$$->isbool = true;
			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);i2_a++;
			emit(LE, "", $1->symp->name, $3->symp->name);
			emit (GOTOOP, "");i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	;

equality_expression
	: relational_expression {$$ = $1;printf("equality_expression -> relational_expression\n");}
	| equality_expression EQ_OP relational_expression {printf("equality_expression -> equality_expression EQ_OP relational_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			// If any is bool get its value
			convertfrombool ($1);
			convertfrombool ($3);i2_a++;
			
			$$ = new expr();
			$$->isbool = true;i2_a++;
			
			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);i2_a++;
			emit (EQOP, "", $1->symp->name, $3->symp->name);
			emit (GOTOOP, "");i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	| equality_expression NE_OP relational_expression {printf("equality_expression -> equality_expression NE_OP relational_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			// If any is bool get its value
			convertfrombool ($1);
			convertfrombool ($3);i2_a++;
			
			$$ = new expr();
			$$->isbool = true;i2_a++;
			
			$$->truelist = makelist (nextinstr());
			$$->falselist = makelist (nextinstr()+1);i2_a++;
			emit (NEOP, "", $1->symp->name, $3->symp->name);
			emit (GOTOOP, "");i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	;

and_expression
	: equality_expression {$$ = $1;printf("and_expression -> equality_expression\n");}
	| and_expression '&' equality_expression {printf("and_expression -> and_expression '&' equality_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			$$ = new expr();
			$$->isbool = false;i2_a++;

			$$->symp = gentemp (_INT);
			emit (BAND, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;i2_a++;
	}
	;

exclusive_or_expression
	: and_expression {$$ = $1;printf("exclusive_or_expression -> and_expression\n");}
	| exclusive_or_expression '^' and_expression {printf("exclusive_or_expression -> exclusive_or_expression '^' and_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			// If any is bool get its value
			convertfrombool ($1);
			convertfrombool ($3);i2_a++;

			$$ = new expr();
			$$->isbool = false;i2_a++;

			$$->symp = gentemp (_INT);
			emit (XOR, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;
	}
	;

inclusive_or_expression
	: exclusive_or_expression {$$ = $1;printf("inclusive_or_expression -> exclusive_or_expression\n");}
	| inclusive_or_expression '|' exclusive_or_expression {printf("inclusive_or_expression -> inclusive_or_expression '|' exclusive_or_expression\n");
		if (typecheck ($1->symp, $3->symp) ) {
			// If any is bool get its value
			convertfrombool ($1);
			convertfrombool ($3);i2_a++;

			$$ = new expr();
			$$->isbool = false;i2_a++;
			
			$$->symp = gentemp (_INT);
			emit (INOR, $$->symp->name, $1->symp->name, $3->symp->name);i2_a++;
		}
		else cout << "Type Error"<< endl;
	}
	;

logical_and_expression
	: inclusive_or_expression {$$ = $1;printf("logical_and_expression -> inclusive_or_expression \n");}
	| logical_and_expression N AND_OP M inclusive_or_expression {printf("logical_and_expression -> logical_and_expression N AND_OP M inclusive_or_expression \n");
		convert2bool($5);i1_a++;

		// N to convert $1 to bool
		backpatch($2->nextlist, nextinstr());i1_a++;
		convert2bool($1);

		$$ = new expr();i1_a++;
		$$->isbool = true;i1_a++;

		backpatch($1->truelist, $4);
		$$->truelist = $5->truelist;i1_a++;
		$$->falselist = merge ($1->falselist, $5->falselist);i1_a++;
	}
	;

logical_or_expression
	: logical_and_expression {$$ = $1;i1_a++;printf("logical_or_expression -> logical_and_expression \n");}
	| logical_or_expression N OR_OP M logical_and_expression {printf("logical_or_expression -> logical_and_expression N OR_OP M logical_and_expression \n");
		convert2bool($5);i1_a++;

		// N to convert $1 to bool
		backpatch($2->nextlist, nextinstr());
		convert2bool($1);i1_a++;

		$$ = new expr();
		$$->isbool = true;i1_a++;

		backpatch ($$->falselist, $4);
		$$->truelist = merge ($1->truelist, $5->truelist);i1_a++;
		$$->falselist = $5->falselist;i1_a++;
	}
	;

M 	: %empty{	// To store the address of the next instruction for further use.
		$$ = nextinstr();i1_a++;printf("M -> empty \n");
	};

N 	: %empty { 	// Non terminal to prevent fallthrough by emitting a goto
		debug ("n");i1_a++;printf("N -> empty \n");
		$$  = new expr();i1_a++;
		$$->nextlist = makelist(nextinstr());i1_a++;
		emit (GOTOOP,"");
		debug ("n2");i1_a++;
	};

conditional_expression
	: logical_or_expression {$$ = $1;printf("conditional_exp -> log_exp \n");}
	| logical_or_expression N '?' M expression N ':' M conditional_expression {
		//convert2bool($1);i1_a++;
		expr* texp = new expr();
		*texp = *$1;
		expr* texp1 = new expr();
		*texp = *$1;
		$$->symp = gentemp();
		*texp1 = *$$;
		$$->symp->update($5->symp->type);i1_a++;
		emit(EQUAL, $$->symp->name, $9->symp->name);
		lint l = makelist(nextinstr());i1_a++;
		emit (GOTOOP, "");
		backpatch($6->nextlist, nextinstr());i1_a++;
		emit(EQUAL, $$->symp->name, $5->symp->name);
		lint m = makelist(nextinstr());i1_a++;
		l = merge (l, m);
		emit (GOTOOP, "");i1_a++;
		backpatch($2->nextlist, nextinstr());
		if(!$1->isbool){
			//texp1->symp->name = $1->symp->name;
			$1->symp->name = texp->symp->name;
			
		}
		convert2bool ($1);i1_a++;
	//	if(!$1->isbool){
	//		$1->symp->name = texp1->symp->name;
	//		//texp1->symp->name = $1->symp->name;
	//	}
		backpatch ($1->truelist, $4);
		backpatch ($1->falselist, $8);i1_a++;
		backpatch (l, nextinstr());
		$$->symp->name = texp1->symp->name;
		printf("conditional_exp -> log_exp ? exp : cond_exp \n");
	}
	;

assignment_expression
	: conditional_expression {
		//cout<<2<<endl;
		//cout<<$$->symp->type->cat<<" "<<_INT<<" "<<ARR<<" "<<PTR<<endl;
		i1_a=0;
		$$ = $1;i1_a++;
		
		i1_a++;
		printf("assignment_expression -> conditional_expression\n");
	}
	| unary_expression assignment_operator assignment_expression {
		i1_a=0;
		printf("assignment_expression -> unary_expression assignment_operator assignment_expression\n");
		switch ($1->cat) {
			case ARR:
				i1_a++;
				//cout<<1<<endl;
				typecheck($1->symp,$3->symp);
				
				emit(ARRL, $1->symp->name, $1->loc->name, $3->symp->name);	
				i1_a++;;
				break;
			case PTR:
				i1_a++;
				//cout<<$1->symp->type->cat<<endl;
				
				typecheck($1->symp,$3->symp);
				//cout<<2<<endl;
				//cout<<$3->symp->name<<endl;
				emit(PTRL, $1->symp->name, $3->symp->name);
				//cout<<2<<endl;	
				i1_a++;
				break;
			default:
				i1_a++;
				//cout<<3<<" "<<$1->cat<<" "<<$1->symp->type->cat<<endl;
				typecheck($1->symp,$3->symp);
				emit(EQUAL, $1->symp->name, $3->symp->name);
				
				i1_a++;				
				break;
		}
		i1_a ++;
		$$ = $3;
		i1_a=0;
		
	}
	;

assignment_operator
	: '='		{i1_a++;printf("assignment_operator->assign\n");i1_a++;}
	| MUL_ASSIGN	{i1_a++;printf("assignment_operator->mul_assign\n");i1_a++;}
	| DIV_ASSIGN	{i1_a++;printf("assignment_operator->div_assign\n");i1_a++;}
	| MOD_ASSIGN	{i1_a++;printf("assignment_operator->mod_assign\n");i1_a++;}
	| ADD_ASSIGN	{i1_a++;printf("assignment_operator->add_assign\n");i1_a++;}
	| SUB_ASSIGN	{i1_a++;printf("assignment_operator->sub_assign\n");i1_a++;}
	| LEFT_ASSIGN	{i1_a++;printf("assignment_operator->left_assign\n");i1_a++;}
	| RIGHT_ASSIGN	{i1_a++;printf("assignment_operator->right_assign\n");i1_a++;}
	| AND_ASSIGN	{i1_a++;printf("assignment_operator->and_assign\n");i1_a++;}
	| XOR_ASSIGN	{i1_a++;printf("assignment_operator->xor_assign\n");i1_a++;}
	| OR_ASSIGN	{i1_a++;printf("assignment_operator->or_assign\n");i1_a++;}
	;

expression
	: assignment_expression {
		{printf("expression -> assignment_expression\n");}
		i1_a= 0;
		$$ = $1;
		i1_a++;
	}
	| expression ',' assignment_expression
	{printf("expression ->expression ',' assignment_expression\n");i1_a++;}
	;

constant_expression
	: conditional_expression
	{i2_a++;printf("constant_expression\n");i2_a++;}
	;

/*** Declaration ***/

declaration
	: declaration_specifiers ';' {printf("declaration -> declration_specifiers ;\n");
	i2_a=0;
	}
	| declaration_specifiers init_declarator_list ';' {
		i2_a++;debug ("declaration");i2_a++;printf("declaration -> declaration_specifiers init_declarator_list ;\n");
	}
	;

declaration_specifiers
	: storage_class_specifier	{i2_a=0;printf("declaration_specifiers->storage_class_specifier\n");i2_a++;}
	| storage_class_specifier declaration_specifiers	{i2_a++;printf("declaration_specifiers->storage_class_specifier declaration_specifiers\n");i2_a++;}
	| type_specifier	{i2_a++;printf("declaration_specifiers->type_specifier\n");i2_a++;}
	| type_specifier declaration_specifiers	{i2_a++;printf("declaration_specifiers->type_specifier declaration_specifiers\n");i2_a++;}
	| type_qualifier	{i2_a++;printf("declaration_specifiers->type_qualifier\n");i2_a++;}
	| type_qualifier declaration_specifiers	{i2_a++;printf("declaration_specifiers->type_qualifier declaration_specifiers\n");i2_a++;}
	| function_specifier {i2_a++;printf("declaration_specifiers-> function_specifier\n");i2_a++;}
	| function_specifier declaration_specifiers
	{i2_a++;printf("declaration_specifiers -> function_specifier declaration_specifiers\n");i2_a++;}
	;

init_declarator_list
	: init_declarator {i1_a=0;printf("init_declarator_list -> init_declarator\n");}
	| init_declarator_list ',' init_declarator {
		i1_a++;debug("init_declarator_list");i1_a++;printf("init_declarator_list -> init_declarator_list ',' init_declarator\n");
	}
	;

init_declarator
	: declarator {i1_a=0;
		$$ = $1;i1_a++;printf("init_declarator -> declarator\n");
	}
	| declarator '=' initializer {i1_a=0;
		debug ($1->name);i1_a++;
		debug ($3->name);i1_a++;
		debug ($3->init);i1_a++;
		if ($3->init!="") $1->initialize($3->init);i1_a++;
		emit (EQUAL, $1->name, $3->name);i1_a++;
		debug ("here init");i1_a++;
	}
	;

storage_class_specifier
	: EXTERN	{i1_a=0;printf("storage_class_specifier -> EXTERN\n");i1_a++;}
	| STATIC	{i1_a++;printf("storage_class_specifier -> STATIC\n");i1_a++;}
	| AUTO		{i1_a++;printf("storage_class_specifier -> AUTO\n");i1_a++;}
	| REGISTER	{i1_a++;printf("storage_class_specifier -> REGISTER\n");i1_a++;}
	;

type_specifier
	: VOID {
		TYPE = _VOID;i2_a=0;printf("type_specifier -> void\n");i2_a++;
	}
	| CHAR {
		TYPE = _CHAR;i2_a++;printf("type_specifier -> char\n");i2_a++;
	}
	| SHORT	{i2_a++;printf("type_specifier -> short\n");i2_a++;}
	| INT {
		TYPE = _INT;i2_a++;printf("type_specifier -> int\n");i2_a++;
	}
	| LONG	{i2_a++;printf("type_specifier -> long\n");i2_a++;}
	| FLOAT	{TYPE = _FLOAT;i2_a++;printf("type_specifier -> float\n");i2_a++;}
	| DOUBLE {
		i2_a++;printf("type_specifier -> double\n");i2_a++;
	}
	| SIGNED	{i2_a=0;printf("type_specifier -> signed\n");i2_a++;}
	| UNSIGNED	{i2_a++;printf("type_specifier -> unsigned\n");i2_a++;}
	| BOOL		{i2_a++;printf("type_specifier -> bool\n");i2_a++;}
	| COMPLEX	{i2_a++;printf("type_specifier -> complex\n");i2_a++;}
	| IMAGINARY	{i2_a++;printf("type_specifier -> imaginry\n");i2_a++;}
	| enum_specifier {i2_a++;printf("type_specifier -> enum_specifier\n");i2_a++;}
	;



specifier_qualifier_list
	: type_specifier specifier_qualifier_list	{i1_a=0;printf("specifier_qualifier_list -> type_specifier specifier_qualifier_list\n");i1_a++;}
	| type_specifier	{i1_a++;printf("specifier_qualifier_list -> type_specifier\n");}
	| type_qualifier specifier_qualifier_list	{i1_a++;printf("specifier_qualifier_list -> type_qualifier specifier_qualifier_list\n");}	
	| type_qualifier	{i1_a++;printf("specifier_qualifier_list -> type_qualifier\n");}
	;


enum_specifier
	: ENUM '{' enumerator_list '}'		{i1_a=0;printf("enum_specifier -> enum {enumerator_list}\n");}
	| ENUM IDENTIFIER '{' enumerator_list '}'		{i1_a++;printf("enum_specifier -> enum_identifier {enumerator_list}\n");}
	| ENUM '{' enumerator_list ',' '}'		{i1_a++;printf("enum_specifier -> enum {enumerator_list}\n");}
	| ENUM IDENTIFIER '{' enumerator_list ',' '}'		{i1_a++;printf("enum_specifier -> enum identifier {enumerator_list}\n");}
	| ENUM IDENTIFIER		{i1_a++;printf("enum_specifier -> enum identifier\n");}
	;

enumerator_list
	: enumerator	{i1_a++;printf("enumerator_list -> enumerator\n");}
	| enumerator_list ',' enumerator	{i1_a++;printf("enumerator_list -> enumerator_list , enumerator\n");}
	;

enumerator
	: IDENTIFIER					{printf("enumerator -> identiifier\n");i2_a++;}
	| IDENTIFIER '=' constant_expression		{printf("enumerator -> identifier = constant _expression\n");i2_a++;}
	;

type_qualifier /* Ignored */
	: CONST			{i2_a=0;printf("type_qualifier -> const\n");}
	| VOLATILE		{i2_a++;printf("type_qualifier -> volatile\n");}
	| RESTRICT		{i2_a++;printf("type_qualifier -> restrict\n");}
	;

function_specifier /* Ignored */
	: INLINE	{printf("function_specifier -> inline\n");i2_a++;}
	;

declarator
	: pointer direct_declarator {
		i2_a=0;
		symtype * t = $1;i2_a++;
		while (t->ptr !=NULL) t = t->ptr;i2_a++;
		t->ptr = $2->type;i2_a++;
		$$ = $2->update($1);i2_a++;printf("declarator -> pointer direct_declarator\n");
	}
	| direct_declarator{i2_a=0;printf("declarator -> direct_declarator\n");}
	;

direct_declarator
	: IDENTIFIER {
		i2_a=0;
		$$ = $1->update(TYPE);i2_a++;
		debug ("currsym: "<< $$->name);i2_a++;
		currsym = $$;i2_a++;printf("direct_declarator -> identifier\n");
	}
	| '(' declarator ')' {i2_a++;
		$$ = $2;i2_a++;printf("direct_declarator -> (declarator)\n");
	}
	| direct_declarator '[' type_qualifier_list ']' {i2_a++;printf("direct_declarator -> direct_declarator '[' type_qualifier_list ']'\n");}
	| direct_declarator '[' type_qualifier_list assignment_expression ']' {i2_a++;printf("direct_declarator -> direct_declarator '[' type_qualifier_list assignment_expression ']'\n");}
	| direct_declarator '[' assignment_expression ']' {i2_a=0;printf("direct_declarator -> direct_declarator '[' assignment_expression ']'\n");
		symtype * t = $1 -> type;i2_a++;
		symtype * prev = NULL;i2_a++;
		while (t->cat == ARR) {i2_a++;
			prev = t;i2_a++;
			t = t->ptr;i2_a++;
		}
		if (prev==NULL) {
			int x = atoi($3->symp->init.c_str());i2_a++;
			symtype* s = new symtype(ARR, $1->type, x);i2_a++;
			int y = sizeoftype(s);i2_a++;
			$$ = $1->update(s);i2_a++;
		}
		else {i2_a=0;
			prev->ptr =  new symtype(ARR, t, atoi($3->symp->init.c_str()));i2_a++;
			$$ = $1->update ($1->type);i2_a++;
		}
	}
	| direct_declarator '[' ']' {printf("direct_declarator -> direct_declarator '[' ']'\n");
		symtype * t = $1 -> type;i1_a=0;
		symtype * prev = NULL;i1_a++;
		while (t->cat == ARR) {i1_a++;
			prev = t;
			t = t->ptr;i1_a++;
		}
		if (prev==NULL) {
			symtype* s = new symtype(ARR, $1->type, 0);i1_a++;
			int y = sizeoftype(s);i1_a++;
			$$ = $1->update(s);
		}
		else {
			prev->ptr =  new symtype(ARR, t, 0);i1_a=0;
			$$ = $1->update ($1->type);i1_a++;
		}
	}
	| direct_declarator '[' STATIC type_qualifier_list assignment_expression ']' {i1_a=0;printf("direct_declarator -> direct_declarator '[' STATIC type_qualifier_list assignment_expression ']' \n");}
	| direct_declarator '[' STATIC assignment_expression ']'{i1_a++;printf("direct_declarator -> direct_declarator '[' STATIC assignment_expression ']'\n");}
	| direct_declarator '[' type_qualifier_list '*' ']'{i1_a++;printf("direct_declarator -> direct_declarator '[' type_qualifier_list '*' ']'\n");}
	| direct_declarator '[' '*' ']'{i1_a++;printf("direct_declarator -> direct_declarator '[' '*' ']'\n");}
	| direct_declarator '(' CST parameter_type_list ')' {printf("direct_declarator -> direct_declarator '(' CST parameter_type_list ')'\n");
		table->tname = $1->name;i1_a++;

		if ($1->type->cat !=_VOID) {
			sym *s = table->lookup("retVal");i1_a++;
			s->update($1->type);i1_a++;		
		}

		$1 = $1->linkst(table);i1_a++;

		table->parent = gTable;i1_a++;// Come back to globalsymbol table
		changeTable (gTable);				
		i1_a++;
		debug ("currsym: "<< $$->name);i1_a++;
		currsym = $$;			i1_a=0;			
	}
	| direct_declarator '(' identifier_list ')' { i1_a++;printf("direct_declarator -> direct_declarator '(' identifier_list ')'\n");/* Ignored */

	}
	| direct_declarator '(' CST ')' {printf("direct_declarator -> direct_declarator '(' CST ')'\n");		
		table->tname = $1->name;i1_a++;		// Update function symbol table name

		if ($1->type->cat !=_VOID) {
			sym *s = table->lookup("retVal");i1_a++;// Update type of return value
			s->update($1->type);i1_a++;
		}
		
		$1 = $1->linkst(table);i1_a++;		// Update type of function in global table
	
		table->parent = gTable;i1_a++;
		changeTable (gTable);	i1_a++;		// Come back to globalsymbol table
	
		debug ("currsym: "<< $$->name);i1_a++;
		currsym = $$;i1_a=0;
	}
	;

CST : %empty { // Used for changing to symbol table for a function
		if (currsym->nest==NULL) {changeTable(new symtab(""));i1_a++;}	// Function symbol table doesn't already exist
		else changeTable (currsym ->nest);	i1_a=0;					// Function symbol table already exists
	}
	;

pointer
	: '*' {i1_a=0;	
		$$ = new symtype(PTR);i1_a++;
			printf("pointer -> *\n");i1_a++;}
	| '*' type_qualifier_list 		{i1_a++;printf("pointer -> * type_qualifier_list\n");i1_a++;} /* Ignored */
	| '*' pointer {i1_a++;	
		$$ = new symtype(PTR, $2);i1_a++;
	printf("pointer -> * pointer\n");i1_a++;}
	| '*' type_qualifier_list pointer /* Ignored */		{i1_a++;printf("pointer -> * type_qualifier_list pointer\n");i1_a++;}
	
	;

type_qualifier_list /* Ignored */
	: type_qualifier			{i1_a++;printf("type_qualifier_list -> type_qualifier\n");i1_a++;}
	| type_qualifier_list type_qualifier	{i1_a++;printf("type_qualifier_list -> type_qualifier_list type_qualifier\n");i1_a=0;}
	;


parameter_type_list
	: parameter_list		{i1_a++;printf("parameter_type_list -> parameter_list \n");i1_a++;}
	| parameter_list ',' ELLIPSIS	{i1_a++;printf("parameter_type_list -> parameter_list , Ellipsis\n");i1_a=0;}
	;

parameter_list
	: parameter_declaration {i1_a++;}
	| parameter_list ',' parameter_declaration {i1_a++;
		debug("parameter_list");i1_a=0;
	}
	;

parameter_declaration
	: declaration_specifiers declarator {i2_a=0;
		debug ("here");i2_a++;
		$2->category = "param";printf("parameter_declaration -> declaration_specifiers declarator\n");i2_a++;
	}
	| declaration_specifiers
	{i2_a++;printf("parameter_declaration -> declaration_specifiers\n");i2_a=0;}
	;

identifier_list
	: IDENTIFIER 				{i2_a++;printf("identifier_list -> Identifier\n");i2_a++;}
	| identifier_list ',' IDENTIFIER	{i2_a++;printf("identifier_list -> identifier_list , identifier\n");i2_a=0;}
	;

type_name
	: specifier_qualifier_list
	{i2_a++;printf("type_name -> specifier_qualifier_list\n");i2_a=0;}
	;


initializer
	: assignment_expression {i2_a++;
		$$ = $1->symp;printf("initializer -> assignment_expression\n");
	i2_a++;}
	| '{' initializer_list '}' {i2_a++;printf("initializer -> {intializer_list}\n");i2_a++;}
	| '{' initializer_list ',' '}'
	{i2_a++;printf("initializer -> {intializer_list ,}\n");}
	;

initializer_list
	: initializer				{i2_a++;printf("initializer_list -> initializer\n");i2_a++;}
	| designation initializer			{i2_a++;printf("initializer_list -> designation initializer\n");i2_a++;}
	| initializer_list ',' initializer			{i2_a++;printf("initializer_list -> initializer_list , initializer\n");i2_a++;}
	|  initializer_list ',' designation initializer		{i2_a++;printf("initializer_list -> initializer_list , designation initializer\n");i2_a++;}
	;

designation
	: designator_list '='
	{i2_a++;printf("designation -> designator_list = \n");i2_a++;}
	;

designator_list
	: designator		{i2_a=0;printf("designator_list -> designator\n");i2_a=0;}
	| designator_list designator	{i2_a++;printf("designator_list -> designator_list designator\n");i2_a=0;}
	;

designator
	: '[' constant_expression ']'	{i2_a=0;printf("designator -> [constant_expression]\n");i2_a++;printf("designator -> [const_exp]\n");}
	| '.' IDENTIFIER	{i2_a++;printf("designator -> . identifier\n");i2_a=0;printf("designator -> . identifier\n");}
	;

statement
	: labeled_statement /* Skipped */{printf("statement -> labeled_statement\n");}
	| compound_statement {i2_a=0;
		$$ = $1;i2_a++;
		debug("Compound Statement");printf("statement -> compound_statement\n");
	}
	| expression_statement {i2_a++;
		$$ = new statement();i2_a++;
		$$->nextlist = $1->nextlist;i2_a++;printf("statement -> expression_statement\n");
		debug("Expression Statement");
	}
	| selection_statement {i2_a++;
		$$ = $1;i2_a++;
		debug("selection statement\n");i2_a++;printf("statement -> selection_statement\n");
	}
	| iteration_statement {
		$$ = $1;i2_a++;
		debug("iteration statement");i2_a++;printf("statement -> iteration_statement\n");
	}
	| jump_statement {
		$$ = $1;i2_a++;
		debug("jump statement");i2_a=0;printf("statement -> jump_statement\n");
	}
	;

labeled_statement /* Ignored */
	: IDENTIFIER ':' statement {i2_a=0;$$ = new statement();i2_a++;printf("labeled_statement -> identifier : statement\n");}
	| CASE constant_expression ':' statement {i2_a++;$$ = new statement();i2_a++;printf(" labeled_statement-> case constant_expression : statement\n");}
	| DEFAULT ':' statement {i2_a++;$$ = new statement();i2_a=0;printf("labeled_statement -> default : statement \n");}
	;

compound_statement
	: '{' '}' { i2_a=0;$$ = new statement();printf("compound_statement -> {}\n");}
	| '{' block_item_list '}' {i2_a++;
		$$ = $2;i2_a=0;
		printf("compound_statement -> {block_item_list}\n");
	}
	;

block_item_list
	: block_item {i2_a=0;
		$$ = $1;	i2_a++;printf("block_item_list -> block_item\n");	
	}
	| block_item_list M block_item {i2_a++;
		$$ = $3;i2_a++;
		backpatch ($1->nextlist, $2);i2_a=0;printf("block_item_list -> block_item_list block_item\n");
	}
	;

block_item
	: declaration { i2_a=0;
		$$ = new statement();i2_a++;printf("block_item -> declaration\n");
	}
	| statement {i2_a++;
		$$ = $1;i2_a=0;printf("block_item -> statement\n");
	}
	;

expression_statement
	: ';' {	i1_a++;$$ = new expr();printf("expression_statement -> ; \n");}
	| expression ';' {i1_a++;
		$$ = $1;i1_a=0;printf("exp_statement -> expression\n");
	}
	;

selection_statement
	: IF '(' expression N ')' M statement N {i1_a=0;
		backpatch ($4->nextlist, nextinstr());i1_a++;
		convert2bool($3);
		$$ = new statement();i1_a++;
		backpatch ($3->truelist, $6);
		lint temp = merge ($3->falselist, $7->nextlist);i1_a++;
		$$->nextlist = merge ($8->nextlist, temp);i1_a=0;
		
	i1_a++;printf("selection_statement -> if\n");}
	| IF '(' expression N ')' M statement N ELSE M statement N {i1_a=0;
		backpatch ($4->nextlist, nextinstr());i1_a++;
		$$ = new statement();
		convert2bool($3);i1_a++;
		backpatch ($3->truelist, $6);i1_a++;
		backpatch ($3->falselist, $10);i1_a++;
		lint temp = merge ($7->nextlist, $8->nextlist);i1_a++;
		lint temp1 = merge (temp, $12->nextlist);i1_a++;
		$$->nextlist = merge (temp1, $11->nextlist);i1_a=0;
		
	i1_a++;printf("selection_statement -> if-else\n");}
	| SWITCH '(' expression ')' statement /* Skipped */
	{i1_a++;printf("selection_statement -> switch\n");}
	;

iteration_statement 	
	: WHILE M '(' expression ')' M statement { 
		$$ = new statement();i1_a=0;
		convert2bool($4);i1_a++;
		// M1 to go back to boolean again
		// M2 to go to statement if the boolean is true
		backpatch($7->nextlist, $2);
		backpatch($4->truelist, $6);i1_a++;
		$$->nextlist = $4->falselist;i1_a++;
		// Emit to prevent fallthrough
		emit (GOTOOP, tostr($2));i1_a=0;
	printf("iteration_statement -> while\n");}
	| DO M statement M WHILE '(' expression ')' ';' {
		i1_a++;$$ = new statement();i1_a++;
		convert2bool($7);
		// M1 to go back to statement if expression is true
		// M2 to go to check expression if statement is complete
		backpatch ($7->truelist, $2);i1_a++;
		backpatch ($3->nextlist, $4);

		// Some bug in the next statement
		$$->nextlist = $7->falselist;i1_a=0;
		printf("iteration_statement -> do while\n");

	}
	| FOR '(' expression_statement M expression_statement ')' M statement {i1_a++;
		$$ = new statement();i1_a++;
		convert2bool($5);i1_a++;
		backpatch ($5->truelist, $7);i1_a++;
		backpatch ($8->nextlist, $4);i1_a++;
		emit (GOTOOP, tostr($4));i1_a++;
		$$->nextlist = $5->falselist;i1_a++;
		printf("iteration_statement -> for\n");
	}
	| FOR '(' expression_statement M expression_statement M expression N ')' M statement {
		$$ = new statement();i1_a++;
		convert2bool($5);
		backpatch ($5->truelist, $10);i1_a++;
		backpatch ($8->nextlist, $4);
		backpatch ($11->nextlist, $6);i1_a++;
		emit (GOTOOP, tostr($6));
		$$->nextlist = $5->falselist;i1_a++;
		printf("iteration_statement -> for (exp exp exp)\n");
	//	debug ("for done");
	}
	;

jump_statement /* Ignored except return */
	: GOTO IDENTIFIER ';' {$$ = new statement();i1_a++;printf("jump_statement -> goto identifier\n");}
	| CONTINUE ';' {i1_a++;$$ = new statement();printf("jump_statement -> continue\n");}
	| BREAK ';' {i1_a++;$$ = new statement();printf("jump_statement -> break\n");}
	| RETURN ';' {
		i1_a++;$$ = new statement();
		emit(_RETURN,"");
	printf("jump_statement -> return\n");
	}
	| RETURN expression ';'{
		i1_a++;$$ = new statement();
		emit(_RETURN,$2->symp->name);	i1_a=0;	
		printf("jump_statement -> return expression ;\n");
	}
	;

translation_unit
	: external_declaration {printf("translation unit -> extern defn\n");}
	| translation_unit external_declaration {i1_a++;printf("translation_unit -> translatio_unit extern_declaration\n");
	}
	;

external_declaration
	: function_definition{printf("extern_declaration -> function_defn\n");}
	| declaration	{printf("extern_decl  -> declaration \n");}
	;

function_definition
	: declaration_specifiers declarator declaration_list CST compound_statement {
	i1_a++;
	printf("func_decl -> decl_specifiers declarator decl_list CST compound_statement\n");
	}
	| declaration_specifiers declarator CST compound_statement {i1_a++;
		table->parent = gTable;
		changeTable (gTable);printf("jump_statement -> return\n");
	}
	;
declaration_list
	: declaration			{printf("declaration_list -> declaration\n");}
	| declaration_list declaration	{printf("declaration_list -> declaration_list declaration\n");}
	;

%%

void yyerror(const char *s) {
	printf ("ERROR: %s",s);
}
