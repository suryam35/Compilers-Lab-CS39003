//	Amatya Sharma
// 	17CS30042
// 	Compilers : Assignment 4

%{
  #include <stdio.h>
  extern int yylex(void);
  void yyerror(char* s);
%}


////////////////////////	Definitions 	////////////////////////////////

%token AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM EXTERN FLOAT FOR GOTO IF INLINE INT LONG REGISTER RESTRICT RETURN SHORT SIGNED SIZEOF STATIC STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE BOOL COMPLEX IMAGINARY IDENTIFIER INTEGER_CONSTANT FLOATING_CONSTANT ENUMERATION_CONSTANT CHARACTER_CONSTANT STRING_LITERAL LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET LEFT_ROUND_BRACKET RIGHT_ROUND_BRACKET DOT LEFT_POINTER PLUS_PLUS MINUS_MINUS AMPERSAND LINE UP_ARROW PLUS MINUS STAR BACK_SLASH PERCENTAGE TILDA EXCLAMATION AMPERSAND_AMPERSAND LINE_LINE GREAT_GREAT LESS_LESS LESS GREAT LESS_EQUAL GREAT_EQUAL EQUAL_EQUAL EXCL_EQUAL QUEST_MARK COLON SEMI_COLON DOTDOTDOT EQUAL STAR_EQUAL BACKSLASH_EQUAL PLUS_EQUAL MINUS_EQUAL PERCENT_EQUAL LESS_LESS_EQUAL GREAT_GREAT_EQUAL AMP_EQUAL UPARROW_EQUAL LINE_EQUAL COMMA HASH ESCAPE_SEQUENCE ERROR
	
%expect 1
%start translation_unit

%% 
///////////////////////////////////////////////  Expressions 	///////////////////////////////////////////////


primary_expression: IDENTIFIER { printf("\n<primary-expression rule 1>\n"); }
		  | INTEGER_CONSTANT { printf("\n<primary-expression rule 2>\n"); }
		  | FLOATING_CONSTANT   { printf("\n<primary-expression rule 2>\n"); }
		  | CHARACTER_CONSTANT    { printf("\n<primary-expression rule 2>\n"); }
		  | STRING_LITERAL { printf("\n<primary-expression rule 3>\n"); }
		  | LEFT_ROUND_BRACKET expression RIGHT_ROUND_BRACKET { printf("\n<primary-expression rule 4>\n"); }
		  ;


postfix_expression:primary_expression      				 { printf("\n<postfix-expression rule 1>\n"); }
		  |postfix_expression LEFT_SQUARE_BRACKET expression RIGHT_SQUARE_BRACKET { printf("\n<postfix-expression rule 2>\n"); }
		  |postfix_expression LEFT_ROUND_BRACKET argument_expression_list_opt RIGHT_ROUND_BRACKET
		  { printf("\n<postfix-expression rule 3>\n"); }
	      |postfix_expression DOT IDENTIFIER { printf("\n<postfix-expression rule 4>\n"); }
		  |postfix_expression LEFT_POINTER IDENTIFIER  { printf("\n<postfix-expression rule 5>\n"); }
		  |postfix_expression PLUS_PLUS  { printf("\n<postfix-expression rule 6>\n"); }
		  |postfix_expression MINUS_MINUS  { printf("\n<postfix-expression rule 7>\n"); }
		  |LEFT_ROUND_BRACKET type_name RIGHT_ROUND_BRACKET LEFT_CURLY_BRACKET initializer_list RIGHT_CURLY_BRACKET { printf("\n<postfix-expression rule 8>\n"); }
		  |LEFT_ROUND_BRACKET type_name RIGHT_ROUND_BRACKET LEFT_CURLY_BRACKET initializer_list COMMA RIGHT_CURLY_BRACKET { printf("\n<postfix-expression rule 9>\n"); }
		  ;


argument_expression_list:assignment_expression    { printf("\n<argument-expression-list rule 1>\n"); }
			|argument_expression_list COMMA assignment_expression     { printf("\n<argument-expression-list rule 2>\n"); }
			;


unary_expression:postfix_expression   { printf("\n<unary-expression rule 1>\n"); }
		|PLUS_PLUS unary_expression   { printf("\n<unary-expression rule 2>\n"); }
		|MINUS_MINUS unary_expression    { printf("\n<unary-expression rule 3>\n"); }
		|unary_operator cast_expression   { printf("\n<unary-expression rule 4>\n"); }
		|SIZEOF unary_expression  { printf("\n<unary-expression rule 5>\n"); }
		|SIZEOF LEFT_ROUND_BRACKET type_name RIGHT_ROUND_BRACKET   { printf("\n<unary-expression rule 6"); }
		;


unary_operator:AMPERSAND { printf("\n<unary-operator rule 1>\n"); }
	  |STAR  { printf("\n<unary-operator rule 2>\n"); }
	  |PLUS  { printf("\n<unary-operator rule 3>\n"); }
	  |MINUS  { printf("\n<unary-operator rule 4>\n"); }
	  |TILDA  { printf("\n<unary-operator rule 5>\n"); } 
	  |EXCLAMATION  { printf("\n<unary-operator rule 6>\n"); }
	  ;


cast_expression:unary_expression  { printf("\n<cast-expression rule 1>\n"); }
	   |LEFT_ROUND_BRACKET type_name RIGHT_ROUND_BRACKET cast_expression  { printf("\n<cast-expression rule 2>\n"); }
	   ;


multiplicative_expression:cast_expression  { printf("\n<multiplicative-expression rule 1>\n");}
			 |multiplicative_expression STAR cast_expression   { printf("\n<multiplicative-expression rule 2>\n");}
			 |multiplicative_expression BACK_SLASH cast_expression   { printf("\n<multiplicative-expression rule 3>\n");}
			 |multiplicative_expression PERCENTAGE cast_expression   { printf("\n<multiplicative-expression rule 4>\n"); }
			 ;


additive_expression:multiplicative_expression   { printf("\n<additive-expression rule 1>\n"); }
		   |additive_expression PLUS multiplicative_expression    { printf("\n<additive-expression rule 2>\n"); }
		   |additive_expression MINUS multiplicative_expression    { printf("\n<additive-expression  rule 3>\n");  }
		   ;


shift_expression:additive_expression   { printf("\n<shift-expression rule 1>\n"); }
		|shift_expression LESS_LESS additive_expression   { printf("\n<shift-expression rule 2>\n"); }
		|shift_expression GREAT_GREAT additive_expression   { printf("\n<shift-expression  rule 3>\n"); }
		;


relational_expression:shift_expression   { printf("\n<relational-expression rule 1>\n"); }
		 |relational_expression LESS shift_expression { printf("\n<relational-expression rule 2>\n"); }
		 |relational_expression GREAT shift_expression { printf("\n<relational-expression rule 3>\n"); }
		 |relational_expression LESS_EQUAL shift_expression { printf("\n<relational-expression rule 4>\n"); }
		 |relational_expression GREAT_EQUAL shift_expression { printf("\n<relational-expression rule 5>\n"); }
		 ;


equality_expression:relational_expression  { printf("\n<equality-expression rule 1>\n"); }
		   |equality_expression EQUAL_EQUAL relational_expression   { printf("\n<equality-expression rule 2>\n"); }
		   |equality_expression EXCL_EQUAL relational_expression	   { printf("\n<equality-expression rule 3>\n"); }
		   ;


AND_expression:equality_expression  { printf("\n<AND-expression rule 1>\n"); }
	  |AND_expression AMPERSAND equality_expression  { printf("\n<AND-expression rule 2>\n"); }
	  ;


exclusive_OR_expression:AND_expression  { printf("\n<exclusive-OR-expression rule 1>\n"); }
		  |exclusive_OR_expression UP_ARROW AND_expression    { printf("\n<exclusive-OR-expression rule 2>\n"); }
		  ;


inclusive_OR_expression:exclusive_OR_expression  { printf("\n<inclusive-OR-expression rule 1>\n"); }
		  |inclusive_OR_expression LINE exclusive_OR_expression   { printf("\n<inclusive-OR-expression rule 2>\n"); }
		  ;


logical_AND_expression:inclusive_OR_expression  { printf("\n<logical-AND-expression rule 1>\n"); }
		  |logical_AND_expression AMPERSAND_AMPERSAND inclusive_OR_expression  { printf("\n<logical-AND-expression rule 2>\n"); }
		  ;


logical_OR_expression:logical_AND_expression   { printf("\n<logical-OR-expression rule 1>\n"); }
		|logical_OR_expression LINE_LINE logical_AND_expression    { printf("\n<logical-OR-expression rule 2>\n"); }
		;


conditional_expression:logical_OR_expression   { printf("\n<conditional-expression rule 1>\n"); }
	  	|logical_OR_expression QUEST_MARK expression COLON conditional_expression   { printf("\n<conditional-expression rule 2>\n"); }
	  	;


assignment_expression:conditional_expression   { printf("\n<assignment-expression rule 1>\n"); }
		 |unary_expression assignment_operator assignment_expression   { printf("\n<assignment-expression rule 2>\n"); }
		 ;


assignment_operator:EQUAL   { printf("\n<assignment-operator rule 1>\n"); }
		   |STAR_EQUAL    { printf("\n<assignment-operator rule 2>\n"); }
		   |BACKSLASH_EQUAL    { printf("\n<assignment-operator rule 3>\n"); }
		   |PERCENT_EQUAL    { printf("\n<assignment-operator rule 4>\n"); }
		   |PLUS_EQUAL    { printf("\n<assignment-operator rule 5>\n"); }
		   |MINUS_EQUAL    { printf("\n<assignment-operator rule 6>\n"); }
		   |LESS_LESS_EQUAL    { printf("\n<assignment-operator rule 7>\n"); }
		   |GREAT_GREAT_EQUAL    { printf("\n<assignment-operator rule 8>\n"); }
		   |AMP_EQUAL    { printf("\n<assignment-operator rule 9>\n"); }
		   |UPARROW_EQUAL    { printf("\n<assignment-operator rule 10>\n"); }
		   |LINE_EQUAL    { printf("\n<assignment-operator rule 11>\n"); }
		   ;


expression:assignment_expression  { printf("\n<expression rule 1>\n"); }
	  |expression COMMA assignment_expression   { printf("\n<expression rule 2>\n"); }
	  ;


constant_expression:conditional_expression   { printf("\n<constant-expression rule 1>\n"); }
				   ;	


argument_expression_list_opt:/* EPSILON TRANSITION */   { printf("\n<argument-expression-list-opt rule 1>\n"); }
			|argument_expression_list    { printf("\n<argument-expression-list-opt rule 2>\n"); }
			;



////////////////////////////////////////////// Declarations 	////////////////////////////////////////////


declaration:declaration_specifiers init_declarator_list_opt SEMI_COLON   { printf("\n<declaration rule 1>\n"); }
		   ;


declaration_specifiers:storage_class_specifier declaration_specifiers_opt   { printf("\n<declaration-specifiers rule 1>\n"); }
		  |type_specifier declaration_specifiers_opt  { printf("\n<declaration-specifiers rule 2>\n"); }
		  |type_qualifier declaration_specifiers_opt   { printf("\n<declaration-specifiers rule 3>\n"); }
		  |function_specifier declaration_specifiers_opt   { printf("\n<declaration-specifiers  rule 4>\n"); }
		  ;	


init_declarator_list:init_declarator    { printf("\n<init-declarator-list rule 1>\n"); }
		|init_declarator_list COMMA init_declarator    { printf("\n<init-declarator-list rule 2>\n"); }
		;


init_declarator:declarator   { printf("\n<init-declarator rule 1>\n"); }
	   |declarator EQUAL initializer    { printf("\n<init-declarator rule 2>\n"); }
	   ;
  			

storage_class_specifier:EXTERN  { printf("\n<storage-class-specifier rule 1>\n"); }
		   |STATIC  { printf("\n<storage-class-specifier rule 2>\n"); }
		   |AUTO   { printf("\n<storage-class-specifier rule 3>\n"); }
		   |REGISTER   { printf("\n<storage-class-specifier rule 4>\n"); }
		   ;


type_specifier:VOID   { printf("\n<type-specifier rule 1>\n"); }
	  |CHAR   { printf("\n<type-specifier rule 2>\n"); }
	  |SHORT  { printf("\n<type-specifier rule 3>\n"); }
	  |INT   { printf("\n<type-specifier rule 4>\n"); }
	  |LONG   { printf("\n<type-specifier rule 5>\n"); }
	  |FLOAT   { printf("\n<type-specifier rule 6>\n"); }
	  |DOUBLE   { printf("\n<type-specifier rule 7>\n"); }
	  |SIGNED   { printf("\n<type-specifier rule 8>\n"); }
	  |UNSIGNED   { printf("\n<type-specifier rule 9>\n"); }
	  |BOOL   { printf("\n<type-specifier rule 10>\n"); }
	  |COMPLEX   { printf("\n<type-specifier rule 11>\n"); }
	  |IMAGINARY   { printf("\n<type-specifier rule 12>\n"); }
	  |enum_specifier   { printf("\n<type-specifier rule 13>\n"); }
	  ;


specifier_qualifier_list:type_specifier specifier_qualifier_list_opt   { printf("\n<specifier-qualifier-list rule 1>\n"); }
			|type_qualifier specifier_qualifier_list_opt  { printf("\n<specifier-qualifier-list rule 2>\n"); }
			;


enum_specifier:ENUM identifier_opt LEFT_CURLY_BRACKET enumerator_list RIGHT_CURLY_BRACKET   { printf("\n<enum-specifier rule 1>\n"); }
	  |ENUM identifier_opt LEFT_CURLY_BRACKET enumerator_list COMMA RIGHT_CURLY_BRACKET   { printf("\n<enum-specifier rule 2>\n"); }
	  |ENUM IDENTIFIER { printf("\n<enum-specifier rule 3>\n"); }
	  ;



enumerator_list:enumerator   { printf("\n<enumerator-list rule 1>\n"); }
	   |enumerator_list COMMA enumerator   { printf("\n<enumerator-list rule 2>\n"); }
	   ;


enumerator:IDENTIFIER   { printf("\n<enumerator rule 1>\n"); }
	  |IDENTIFIER EQUAL constant_expression   { printf("\n<enumerator rule 2>\n"); }
	  ;


type_qualifier:CONST   { printf("\n<type-qualifier rule 1>\n"); }
	  |RESTRICT   { printf("\n<type-qualifier rule 2>\n"); }
	  |VOLATILE   { printf("\n<type-qualifier rule 3>\n"); }
	  ;


function_specifier:INLINE   { printf("\n<function-specifier rule 1>\n"); }
				  ;


declarator: pointer_opt direct_declarator   { printf("\n<declarator rule 1>\n"); }
		  ;


direct_declarator:IDENTIFIER   { printf("\n<direct-declarator rule 1>\n"); }
		 |LEFT_ROUND_BRACKET declarator RIGHT_ROUND_BRACKET   { printf("\n<direct-declarator rule 2>\n"); }
		 |direct_declarator LEFT_SQUARE_BRACKET type_qualifier_list_opt assignment_expression_opt RIGHT_SQUARE_BRACKET   { printf("\n<direct-declarator rule 3>\n"); }
		 |direct_declarator LEFT_SQUARE_BRACKET STATIC type_qualifier_list_opt assignment_expression RIGHT_SQUARE_BRACKET   { printf("\n<direct-declarator rule 4>\n"); }
		 |direct_declarator LEFT_SQUARE_BRACKET type_qualifier_list STATIC assignment_expression RIGHT_SQUARE_BRACKET   { printf("\n< rule 5>\n"); }
		 |direct_declarator LEFT_SQUARE_BRACKET type_qualifier_list_opt STAR RIGHT_SQUARE_BRACKET   { printf("\n<direct-declarator rule 6>\n"); }
		 |direct_declarator LEFT_ROUND_BRACKET parameter_type_list RIGHT_ROUND_BRACKET   { printf("\n<direct-declarator rule 7>\n"); }
		 |direct_declarator LEFT_ROUND_BRACKET identifier_list_opt RIGHT_ROUND_BRACKET   { printf("\n<direct-declarator rule 8>\n"); }
		 ;


pointer:STAR type_qualifier_list_opt   { printf("\n<pointer rule 1>\n"); }
   |STAR type_qualifier_list_opt pointer { printf("\n<pointer rule 2>\n"); }
   ;


type_qualifier_list:type_qualifier   { printf("\n<type-qualifier-list rule 1>\n"); }
		   |type_qualifier_list type_qualifier   { printf("\n<type-qualifier-list rule 2>\n"); }
		   ;


parameter_type_list:parameter_list   { printf("\n<parameter-type-list rule 1>\n"); }
		   |parameter_list COMMA DOTDOTDOT   { printf("\n<parameter-type-list rule 2>\n"); }
		   ;


parameter_list:parameter_declaration   { printf("\n<parameter-list rule 1>\n"); }
	  |parameter_list COMMA parameter_declaration    { printf("\n<parameter-list rule 2>\n"); }
	  ;


parameter_declaration:declaration_specifiers declarator   { printf("\n<parameter-declaration rule 1>\n"); }
		 |declaration_specifiers    { printf("\n<parameter-declaration rule 2>\n"); }
		 ;


identifier_list:IDENTIFIER	{ printf("\n<identifier-list rule 1>\n"); }		  
	   |identifier_list COMMA IDENTIFIER   { printf("\n<identifier-list rule 2>\n"); }
	   ;


type_name:specifier_qualifier_list   { printf("\n<type-name rule 1>\n"); }
		 ;


initializer:assignment_expression   { printf("\n<initializer rule 1>\n"); }
	   |LEFT_CURLY_BRACKET initializer_list RIGHT_CURLY_BRACKET  { printf("\n<initializer rule 2>\n"); }
	   |LEFT_CURLY_BRACKET initializer_list COMMA RIGHT_CURLY_BRACKET  { printf("\n<initializer rule 3>\n"); }
	   ;


initializer_list:designation_opt initializer  { printf("\n<initializer_list rule 1>\n"); }
	    |initializer_list COMMA designation_opt initializer   { printf("\n<initializer_list rule 2>\n"); }
	    ;



designation:designator_list EQUAL   { printf("\n<designation rule 1>\n"); }
		   ;


designator_list:designator    { printf("\n<designator-list rule 1>\n"); }
	   |designator_list designator   { printf("\n<designator-list rule 2>\n"); }
	   ;


designator:LEFT_SQUARE_BRACKET constant_expression RIGHT_SQUARE_BRACKET   { printf("\n<designator rule 1>\n"); }
	  |DOT IDENTIFIER { printf("\n<designator rule 2>\n"); }
	  ;




identifier_list_opt:/* EPSILON TRANSITION */   { printf("\n<identifier-list-opt rule 1>\n"); }
		   |identifier_list   { printf("\n<identifier-list-opt rule 2>\n"); }
		   ;

pointer_opt:/* EPSILON TRANSITION */   { printf("\n<pointer-opt rule 1>\n"); }
	   |pointer   { printf("\n<pointer-opt rule 2>\n"); }
	   ;


assignment_expression_opt:/* EPSILON TRANSITION */   { printf("\n<assignment-expression-opt rule 1>\n"); }
			 |assignment_expression  { printf("\n<assignment-expression-opt rule 2>\n"); }
			 ;

type_qualifier_list_opt:/* EPSILON TRANSITION */   { printf("\n<type-qualifier-list-opt rule 1>\n"); }
		   |type_qualifier_list      { printf("\n<type-qualifier-list-opt rule 2>\n"); }
		   ;


designation_opt:/*Empty*/   { printf("\n<designation-opt rule 1>\n"); }
	   |designation   { printf("\n<designation-opt rule 2>\n"); }
	   ;


declaration_specifiers_opt:/* EPSILON TRANSITION */   { printf("\n<declaration-specifiers-opt  rule 1>\n"); }
			  |declaration_specifiers    { printf("\n<declaration-specifiers-opt rule 2>\n"); }
			  ;
 

init_declarator_list_opt:/* EPSILON TRANSITION */   { printf("\n<init-declarator-list-opt  rule 1>\n"); }
		    |init_declarator_list   { printf("\n<init-declarator-list-opt rule 2>\n"); }
		    ;


specifier_qualifier_list_opt:/* EPSILON TRANSITION */   { printf("\n<specifier-qualifier-list-opt rule 1>\n"); }
			    |specifier_qualifier_list  { printf("\n<specifier-qualifier-list-opt rule 2>\n"); }
			    ;


identifier_opt:/* EPSILON TRANSITION */   { printf("\n<identifier-opt rule 1\n"); }
	  |IDENTIFIER   { printf("\n<identifier-opt rule 2\n"); }
	  ;



			
////////////////////////////		Statements		//////////////////////////////////////////////////


statement:labeled_statement   { printf("\n<statement rule 1>\n"); }
	 |compound_statement   { printf("\n<statement rule 2>\n"); }
	 |expression_statement   { printf("\n<statement rule 3>\n"); }
	 |selection_statement   { printf("\n<statement rule 4>\n"); }
	 |iteration_statement   { printf("\n<statement rule 5>\n"); }
	 |jump_statement   { printf("\n<statement rule 6>\n"); }
	 ;


labeled_statement:IDENTIFIER COLON statement   { printf("\n<labeled-statement rule 1>\n"); }
	 |CASE constant_expression COLON statement   { printf("\n<labeled-statement rule 2>\n"); }
	 |DEFAULT COLON statement   { printf("\n<labeled-statement rule 3>\n"); }
	 ;


compound_statement: LEFT_CURLY_BRACKET block_item_list_opt RIGHT_CURLY_BRACKET   { printf("\n<compound-statement rule 1 >\n"); }
				  ;


block_item_list:block_item   { printf("\n<block-item-list rule 1>\n"); }
			   |block_item_list block_item    { printf("\n<block-item-list rule 2>\n"); }
			   ;


block_item:declaration   { printf("\n<block-item rule 1>\n"); }
		  |statement   { printf("\n<block-item rule 2>\n"); }
		  ;



expression_statement:expression_opt SEMI_COLON   { printf("\n<expression-statement rule 1>\n"); }
					;


selection_statement:IF LEFT_ROUND_BRACKET expression RIGHT_ROUND_BRACKET statement   { printf("\n<selection-statement rule 1>\n"); }
				   |IF LEFT_ROUND_BRACKET expression RIGHT_ROUND_BRACKET statement ELSE statement   { printf("\n<selection-statement rule 2>\n"); }
				   |SWITCH LEFT_ROUND_BRACKET expression RIGHT_ROUND_BRACKET statement    { printf("\n<selection-statement rule 3>\n"); }
				   ;


iteration_statement:WHILE LEFT_ROUND_BRACKET expression RIGHT_ROUND_BRACKET statement   { printf("\n<iteration-statement rule 1>\n"); }
				   |DO statement WHILE LEFT_ROUND_BRACKET expression RIGHT_ROUND_BRACKET SEMI_COLON   { printf("\n<iteration-statement rule 2>\n"); }
				   |FOR LEFT_ROUND_BRACKET expression_opt SEMI_COLON expression_opt SEMI_COLON expression_opt RIGHT_ROUND_BRACKET statement   { printf("\n<iteration-statement rule 3>\n"); }
				   |FOR LEFT_ROUND_BRACKET declaration expression_opt SEMI_COLON expression_opt RIGHT_ROUND_BRACKET statement    { printf("\n<iteration-statement rule 4>\n"); }
				   ;


jump_statement:GOTO IDENTIFIER SEMI_COLON   { printf("\n<jump-statement rule 1>\n"); }
			  |CONTINUE SEMI_COLON   { printf("\n<jump-statement rule 2>\n"); }
			  |BREAK SEMI_COLON   { printf("\n<jump-statement rule 3>\n"); }
			  |RETURN expression_opt SEMI_COLON   { printf("\n<jump-statement rule 4>\n"); }
			  ;


expression_opt:/* EPSILON TRANSITION */   { printf("\n<expression-opt rule 1>\n"); }
			  |expression   { printf("\n<expression-opt rule 2>\n"); }
			  ;


block_item_list_opt:/* EPSILON TRANSITION */   { printf("\n<block-item-list-opt rule 1>\n"); }
				   |block_item_list   { printf("\n<block-item-list-opt rule 2>\n"); }
				   ;



////////////////////////////	External Definitions	/////////////////////////////////////////////


translation_unit: external_declaration { printf("\n<translation-unit rule 1\nSuccessful>\n"); }
				| translation_unit external_declaration { printf("\n<translation-unit rule 2>\nSUCCESSFUL\n"); } 
				;


external_declaration:function_definition { printf("\n<external-declaration rule 1>\n"); }
					|declaration   { printf("\n<external-declaration rule 2>\n"); }
					;


function_definition:declaration_specifiers declarator declaration_list_opt compound_statement  { printf("\n<function-definition rule 1>\n"); }
				   ;


declaration_list:declaration   { printf("\n<declaration-list rule 1>\n"); }
				|declaration_list declaration    { printf("\n<declaration-list rule 2>\n"); }
				;		


declaration_list_opt:/* EPSILON TRANSITION */   { printf("\n<declaration-list-opt rule 1>\n"); }
					|declaration_list   { printf("\n<declaration-list-opt rule 2>\n"); }
					;

		   										  				   
%%

void yyerror (char *s) { 
   fprintf (stderr, "%s\n", s);
 }
