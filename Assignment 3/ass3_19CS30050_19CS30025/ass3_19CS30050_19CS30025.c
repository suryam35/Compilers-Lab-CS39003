#include <stdio.h>

extern char* yytext;

void main()
{
	int semantic_symbol;
	while (semantic_symbol = yylex()) 
	{
		switch (semantic_symbol) 
		{
			case AUTO:
				printf("<KEYWORD_AUTO, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case BREAK:
				printf("<KEYWORD_BREAK, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case CHAR:
				printf("<KEYWORD_CHAR, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case CONST:
				printf("<KEYWORD_CONST, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case CONTINUE:
				printf("<KEYWORD_CONTINUE, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case DEFAULT:
				printf("<KEYWORD_DEFAULT, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case DO:
				printf("<KEYWORD_DO, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case DOUBLE:
				printf("<KEYWORD_DOUBLE, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case ELSE:
				printf("<KEYWORD_ELSE, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case ENUM:
				printf("<KEYWORD_ENUM, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case EXTERN:
				printf("<KEYWORD_EXTERN, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case FLOAT:
				printf("<KEYWORD_FLOAT, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case FOR:
				printf("<KEYWORD_FOR, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case GOTO:
				printf("<KEYWORD_GOTO, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case IF:
				printf("<KEYWORD_IF, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case INLINE:
				printf("<KEYWORD_INLINE, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case INT:
				printf("<KEYWORD_INT, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case LONG:
				printf("<KEYWORD_LONG, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case REGISTER:
				printf("<KEYWORD_REGISTER, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case RESTRICT:
				printf("<KEYWORD_RESTRICT, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case RETURN:
				printf("<KEYWORD_RETURN, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case SHORT:
				printf("<KEYWORD_SHORT, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case SIGNED:
				printf("<KEYWORD_SIGNED, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case SIZEOF:
				printf("<KEYWORD_SIZEOF, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case STATIC:
				printf("<KEYWORD_STATIC, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case STRUCT:
				printf("<KEYWORD_STRUCT, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case SWITCH:
				printf("<KEYWORD_SWITCH, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case TYPEDEF:
				printf("<KEYWORD_TYPEDEF, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case UNION:
				printf("<KEYWORD_UNION, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case UNSIGNED:
				printf("<KEYWORD_UNSIGNED, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case VOID:
				printf("<KEYWORD_VOID, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case VOLATILE:
				printf("<KEYWORD_VOLATILE, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case WHILE:
				printf("<KEYWORD_WHILE, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case BOOL:
				printf("<KEYWORD_BOOL, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case COMPLEX:
				printf("<KEYWORD_COMPLEX, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;
			case IMAGINARY:
				printf("<KEYWORD_IMAGINARY, %d, %s>\n",semantic_symbol, yytext);			// case for a keyword
				break;

			case IDENTIFIER: 	
				printf("<IDENTIFIER, %d, %s>\n",semantic_symbol, yytext);       	// Case for identifier
				break;

			case INTEGER_CONSTANT: 
				printf("<INTEGER CONSTANT, %d, %s>\n",semantic_symbol, yytext);  	// Case for integer constant
				break;

			case FLOATING_CONSTANT: 
				printf("<FLOAT CONSTANT, %d, %s>\n",semantic_symbol, yytext); 		// Case for float constant
				break;
			
			case ENUMERATION_CONSTANT: 
				printf("<ENUMERATION CONSTANT, %d, %s>\n",semantic_symbol, yytext); 	// Case for enumeration constant
				break;
				
			case CHARACTER_CONSTANT: 
				printf("<CHARACTER CONSTANT, %d, %s>\n",semantic_symbol, yytext); 	// Case for character constant
				break;

			case ESCAPE_SEQUENCE:
				printf("<ESCAPE CHARACTER, %d, %s>\n",semantic_symbol, yytext);		// Case for escape characters /t,/n ...
				break;

			case STRING_LITERAL: 
				printf("<STRING LITERAL, %d, %s>\n",semantic_symbol, yytext); 		// Case for string
				break;
			case DOT:
				printf("<PUNCTUATOR_DOT, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LEFT_SQUARE_BRACKET:
				printf("<PUNCTUATOR_LEFT_SQUARE_BRACKET, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case RIGHT_SQUARE_BRACKET:
				printf("<PUNCTUATOR_RIGHT_SQUARE_BRACKET, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LEFT_ROUND_BRACKET:
				printf("<PUNCTUATOR_LEFT_ROUND_BRACKET, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case RIGHT_ROUND_BRACKET:
				printf("<PUNCTUATOR_RIGHT_ROUND_BRACKET, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LEFT_CURLY_BRACKET:
				printf("<PUNCTUATOR_LEFT_CURLY_BRACKET, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case RIGHT_CURLY_BRACKET:
				printf("<PUNCTUATOR_RIGHT_CURLY_BRACKET, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LEFT_POINTER:
				printf("<PUNCTUATOR_LEFT_POINTER, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case PLUS_PLUS:
				printf("<PUNCTUATOR_PLUS_PLUS, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case MINUS_MINUS:
				printf("<PUNCTUATOR_MINUS_MINUS, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case AMPERSAND:
				printf("<PUNCTUATOR_AMPERSAND, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case STAR:
				printf("<PUNCTUATOR_STAR, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case PLUS:
				printf("<PUNCTUATOR_PLUS, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case MINUS:
				printf("<PUNCTUATOR_MINUS, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case TILDA:
				printf("<PUNCTUATOR_TILDA, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case EXCLAMATION:
				printf("<PUNCTUATOR_EXCLAMATION, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case BACK_SLASH:
				printf("<PUNCTUATOR_BACK_SLASH, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case PERCENTAGE:
				printf("<PUNCTUATOR_PERCENTAGE, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LESS_LESS:
				printf("<PUNCTUATOR_LESS_LESS, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case GREAT_GREAT:
				printf("<PUNCTUATOR_GREAT_GREAT, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LESS:
				printf("<PUNCTUATOR_LESS, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case GREAT:
				printf("<PUNCTUATOR_GREAT, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LESS_EQUAL:
				printf("<PUNCTUATOR_LESS_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case GREAT_EQUAL:
				printf("<PUNCTUATOR_GREAT_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case EQUAL_EQUAL:
				printf("<PUNCTUATOR_EQUAL_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case EXCL_EQUAL:
				printf("<PUNCTUATOR_EXCL_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case UP_ARROW:
				printf("<PUNCTUATOR_UP_ARROW, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LINE:
				printf("<PUNCTUATOR_LINE, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case AMPERSAND_AMPERSAND:
				printf("<PUNCTUATOR_AMPERSAND_AMPERSAND, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LINE_LINE:
				printf("<PUNCTUATOR_LINE_LINE, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case QUEST_MARK:
				printf("<PUNCTUATOR_QUEST_MARK, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case COLON:
				printf("<PUNCTUATOR_COLON, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case SEMI_COLON:
				printf("<PUNCTUATOR_SEMI_COLON, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case DOTDOTDOT:
				printf("<PUNCTUATOR_DOTDOTDOT, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case EQUAL:
				printf("<PUNCTUATOR_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case STAR_EQUAL:
				printf("<PUNCTUATOR_STAR_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case BACKSLASH_EQUAL:
				printf("<PUNCTUATOR_BACKSLASH_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case PERCENT_EQUAL:
				printf("<PUNCTUATOR_PERCENT_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case PLUS_EQUAL:
				printf("<PUNCTUATOR_PLUS_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case MINUS_EQUAL:
				printf("<PUNCTUATOR_MINUS_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LESS_LESS_EQUAL:
				printf("<PUNCTUATOR_LESS_LESS_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case GREAT_GREAT_EQUAL:
				printf("<PUNCTUATOR_GREAT_GREAT_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case AMP_EQUAL:
				printf("<PUNCTUATOR_AMP_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case UPARROW_EQUAL:
				printf("<PUNCTUATOR_UPARROW_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case LINE_EQUAL:
				printf("<PUNCTUATOR_LINE_EQUAL, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case COMMA:
				printf("<PUNCTUATOR_COMMA, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;
			case HASH:
				printf("<PUNCTUATOR_HASH, %d, %s>\n",semantic_symbol, yytext); 		// case for a punctuator
				break;

			case COMMENT: 
				printf("<COMMENT, %d>\n",semantic_symbol); 				// Case for comment
				break;

			default: 
				printf("<OTHER_SYMBOL, %d, %s>\n",semantic_symbol, yytext); 		// Here default case is set to other symbol. So all others will be treated as other symbol
				break;
		}
	}
}


