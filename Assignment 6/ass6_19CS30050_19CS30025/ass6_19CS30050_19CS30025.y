%{
#include <bits/stdc++.h>
#include <string>
#include <iostream>

using namespace std;
extern int yylex();
void yyerror(string s);
extern int yydebug;
#include "ass6_19CS30050_19CS30025_translator.h"
quad_array QUAD_LIST;
sym_tab gst;
sym_tab *GST = &(gst);
int counts=0;
vector<string> str_consts;
void debug (string str){
	//printf("%s",str);
}
%}




%union {
  char cval;                      // used for storing the character constant value
    int ival;                       // used for storing the integer constant value
    double dval;                    /// used for storing the double constant value
    void* ptr;                      // used for storing the pointer value
    string *str;                    // pointer to a string
    symbol_type *type_info;              // keeps info of all the types
    sym_tab_row *sym_tab_rowdata;              // a pointer to an entry in the symbol table
    Types typee;              // a basic type enum
    //exp *exp_info;
    opcode opp;                     // for storing the opcode of a nonterminal
    expression *exp_info;                 // holds info like loc and type for an expression and truelist false list and next list for statements
    declarations *dec_info;                 // holds info on declartors
    vector<declarations*> *ivec;            // holds a list od declators
    param *prm;                     // holds parameters like name and type of a parameter
    vector<param*> *prm_list;       // holds a list of parameters
}
%token AUTO_KEY;
%token ENUM_KEY;
%token RESTRICT_KEY;
%token UNSIGNED_KEY;
%token BREAK_KEY;
%token EXTERN_KEY;
%token RETURN_KEY;
%token VOID_KEY;
%token CASE_KEY;
%token FLOAT_KEY;
%token SHORT_KEY;
%token VOLATILE_KEY;
%token CHAR_KEY;
%token FOR_KEY;
%token SIGNED_KEY;
%token WHILE_KEY;
%token CONST_KEY;
%token GOTO_KEY;
%token SIZEOF_KEY;
%token BOOL_KEY;
%token CONTINUE_KEY;
%token IF_KEY;
%token STATIC_KEY;
%token COMPLEX_KEY;
%token DEFAULT_KEY;
%token INLINE_KEY;
%token STRUCT_KEY;
%token IMAGINARY_KEY;
%token DO_KEY;
%token INT_KEY;
%token SWITCH_KEY;
%token DOUBLE_KEY;
%token LONG_KEY;
%token TYPEDEF_KEY;
%token ELSE_KEY;
%token REGISTER_KEY;
%token UNION_KEY;
%token <str> IDENTIFIER;
%token <ival>  INTEGER_CONST;
%token <dval> FLOAT_CONST;
%token <ival> ENUMERATION;
%token <cval> CHAR_CONST;
%token <str> STRING_LITERAL;
%token VAL_AT;
%token PLUS_PLUS;
%token MINUS_MINUS;
%token LEFT_SHIFT;
%token RIGHT_SHIFT;
%token LESS_THAN_EQUAL;
%token GREATER_THAN_EQUAL;
%token EQUAL_EQUAL;
%token NOT_EQUAL;
%token LOGICAL_AND;
%token LOGICAL_OR;
%token ELLIPSES;
%token MULTIPLY_EQUAL;
%token DIVIDE_EQUAL;
%token MODULO_EQUAL;
%token PLUS_EQUAL;
%token MINUS_EQUAL;
%token LEFT_SHIFT_EQUAL;
%token RIGHT_SHIFT_EQUAL;
%token AND_EQUAL;
%token BITWISENOT_EQUAL;
%token OR_EQUAL;


%type<exp_info> primary_expression 
%type<exp_info> expression 
%type<exp_info> postfix_expression assignment_expression unary_expression
%type<exp_info> additive_expression multiplicative_expression shift_expression cast_expression
%type<exp_info> relational_expression equality_expression
%type<exp_info> M N conditional_expression logical_or_expression logical_and_expression and_expression exclusive_or_expression inclusive_or_expression
%type<exp_info> selection_statement statement iteration_statement compound_statement expression_statement jump_statement
%type<cval> unary_operator
%type<exp_info> block_item block_item_list
%type<typee> type_specifier declaration_specifiers
%type<ival> pointer
%type<dec_info> direct_declarator initializer_list declarator init_declarator function_prototype
%type<exp_info> initializer
%type<ivec> init_declarator_list
%type<prm> parameter_declaration
%type<prm_list> parameter_list parameter_type_list argument_expression_list parameter_type_list_opt

%expect 1
%nonassoc ELSE_KEY;

%start translation_unit;
%%




primary_expression
	: IDENTIFIER
	{
	 	$$ = new expression;debug("err1");
	 	string t = (*($1));debug("err2");
 	 	GST->lookup(t);debug("err3");
	 	$$->loc=t;debug("err4");
	 	
	}
	| INTEGER_CONST
	{
		$$ = new expression;debug("err5");
		$$->loc = GST->gentemp(INT);debug("err6");
		QUAD_LIST.emit($$->loc,$1,ASSIGN);debug("err7");
		sym_value *insert=new sym_value; 
		insert->set_initial_value($1);debug("err8");
		GST->lookup($$->loc)->init_val = insert;
	}
	| FLOAT_CONST
	{
		$$ = new expression;debug("err9");
		$$->loc = GST->gentemp(DOUBLE);
		QUAD_LIST.emit($$->loc,$1,ASSIGN);debug("err10");
		sym_value *insert=new sym_value();
		insert->set_initial_value($1);debug("err11");
		GST->lookup($$->loc)->init_val = insert;
	}
	| CHAR_CONST
	{
		$$ = new expression;debug("err12");
		$$->loc = GST->gentemp(CHAR);
		QUAD_LIST.emit($$->loc,$1,ASSIGN);debug("err13");
		sym_value *insert=new sym_value();
		insert->set_initial_value($1);debug("err14");
		GST->lookup($$->loc)->init_val = insert;
		
	}
	| ENUMERATION
	{}
	| STRING_LITERAL
	{
		$$ = new expression;debug("err15");
		stringstream conv;
		conv << counts;debug("err16");
		counts++;
		string x;debug("err17");
		conv >> x;
		x=".LC"+x;debug("err18");
		$$->loc=x;
		str_consts.pb(*$1);

	}
	| '(' expression ')'
	{ 
		$$ =$2;debug("err19");
	}
	;

postfix_expression
	: primary_expression {debug("err1");}
	| postfix_expression '[' expression ']'
	{
		
		symbol_type to = GST->lookup($1->loc)->type;debug("err2");
		string f;
		if(!$1->fold)
		{
			f=GST->gentemp(INT);debug("err3");
			QUAD_LIST.emit(f,0,ASSIGN);
			$1->folder=new string(f);debug("err4");
		}

		string temp2=GST->gentemp(INT);
		QUAD_LIST.emit(temp2,$3->loc,"",ASSIGN);debug("err5");
		QUAD_LIST.emit(temp2,temp2,"4",MULT);
		QUAD_LIST.emit(f,temp2,"",ASSIGN);debug("err6");
		
		$$=$1;
		debug("err7");
	}
	| postfix_expression '(' ')'
	{
		sym_tab *func_symtab=gst.lookup($1->loc)->nested_table;debug("err8");
		QUAD_LIST.emit($1->loc,"0","",CALL);
	}
	| postfix_expression '(' argument_expression_list ')'
	{
		
		sym_tab *func_symtab=gst.lookup($1->loc)->nested_table;debug("err9");
		vector<param*> parameters = *($3);
		debug("err10");
		vector<sym_tab_row*> params_list = func_symtab->symbols;
		debug("err11");
		bool extra=false;
		debug("err12");
		for(int i=0;i<parameters.size();i++)
		{
			
			if(params_list[i]->name=="RETVAL")
				extra=true;
			debug("err13");
			QUAD_LIST.emit(parameters[i]->name,"","",PARAM);debug("err14");
		}
		
		if(extra)
		{
			debug("err15");
		}
		else if(params_list.size()>parameters.size())
		{
			debug("err16");
		}

		Types ret_type=func_symtab->lookup("RETVAL")->type.type;
		if(ret_type==VOID){
			QUAD_LIST.emit($1->loc,(int)parameters.size(),CALL);
			debug("err17");
			}
		else
		{
			debug("err18");
			string retval = GST->gentemp(ret_type);
            string siz; debug("err19");
            stringstream conv;
            conv<<parameters.size(); debug("err20");
            conv>>siz;
            QUAD_LIST.emit($1->loc,siz,retval,CALL);
            $$ = new expression; debug("err21");
            $$->loc = retval;
		}
		
	}
	| postfix_expression '.' IDENTIFIER
	{
		debug("err22");
	}
	| postfix_expression VAL_AT IDENTIFIER
	{
		debug("err23");
	}
	| postfix_expression PLUS_PLUS
	{
		$$ = new expression;
		debug("err24");
		symbol_type t=GST->lookup($1->loc)->type;
		if(t.type==ARRAY)
		{	debug("err25");
			$$->loc=GST->gentemp(GST->lookup($1->loc)->type.type2);
			QUAD_LIST.emit($$->loc,$1->loc,*($1->folder),ARR_IDX_ARG);
			debug("err26");
			string temp=GST->gentemp(t.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			QUAD_LIST.emit(temp,temp,"1",ADD);debug("err27");
			QUAD_LIST.emit($1->loc,temp,*($1->folder),ARR_IDX_RES);
			debug("err28");
		}
		else
		{
			$$->loc=GST->gentemp(GST->lookup($1->loc)->type.type);
			debug("err29");
			QUAD_LIST.emit($$->loc,$1->loc,"",ASSIGN);debug("err30");
			QUAD_LIST.emit($1->loc,$1->loc,"1",ADD);
		}

	}
	| postfix_expression MINUS_MINUS
	{	debug("err31");
		$$ = new expression;
		$$->loc=GST->gentemp(GST->lookup($1->loc)->type.type);debug("err32");
		symbol_type t=GST->lookup($1->loc)->type;
		if(t.type==ARRAY)
		{	debug("err33");
			$$->loc=GST->gentemp(GST->lookup($1->loc)->type.type2);
			string temp=GST->gentemp(t.type2);debug("err34");
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			QUAD_LIST.emit($$->loc,temp,"",ASSIGN);
			QUAD_LIST.emit(temp,temp,"1",SUB);debug("err35");
			QUAD_LIST.emit($1->loc,temp,*($1->folder),ARR_IDX_RES);
		}
		else
		{	debug("err36");
			$$->loc=GST->gentemp(GST->lookup($1->loc)->type.type);
			QUAD_LIST.emit($$->loc,$1->loc,"",ASSIGN);debug("err37");
			QUAD_LIST.emit($1->loc,$1->loc,"1",SUB);
		}
	}
	| '(' type_name ')' '{' initializer_list '}'
	{debug("err38");}
	| '(' type_name ')' '{' initializer_list ',' '}'
	{debug("err39");}
	;


argument_expression_list
	: assignment_expression
	{	
	
		param *first=new param;debug("err1");
		first->name=$1->loc;
		first->type=GST->lookup($1->loc)->type;debug("err2");
		$$ = new vector<param*>;
		$$->pb(first);debug("err3");
	}
	| argument_expression_list ',' assignment_expression
	{
		param *next = new param; debug("err4");
		next->name = $3->loc; 
		next->type = GST->lookup(next->name)->type; debug("err5");
		$$ = $1; 
		$$->push_back(next);debug("err6");
	}
	;

unary_expression
	: postfix_expression{debug("err1");}
	{
		
	}
	| PLUS_PLUS unary_expression
	{
		$$ = new expression; debug("err2");
		symbol_type type = GST->lookup($2->loc)->type;
        if(type.type == ARRAY)
        {	debug("err3");
            string t = GST->gentemp(type.type2);
            QUAD_LIST.emit(t,$2->loc,*($2->folder),ARR_IDX_ARG);debug("err4");
            QUAD_LIST.emit(t,t,"1",ADD); 
            QUAD_LIST.emit($2->loc,t,*($2->folder),ARR_IDX_RES);debug("err5");
            $$->loc = GST->gentemp(GST->lookup($2->loc)->type.type2);debug("err6");
        }
        else
        {	
            QUAD_LIST.emit($2->loc,$2->loc,"1",ADD); debug("err7");
            $$->loc = GST->gentemp(GST->lookup($2->loc)->type.type);debug("err8");
        }

		debug("err10");
        $$->loc = GST->gentemp(GST->lookup($2->loc)->type.type); 
        QUAD_LIST.emit($$->loc,$2->loc,"",ASSIGN); debug("err9");
	}
	| MINUS_MINUS unary_expression
	{
		$$ = new expression;
		symbol_type type = GST->lookup($2->loc)->type;debug("err11");
        if(type.type == ARRAY)
        {	debug("err12");
            string t = GST->gentemp(type.type2);
            QUAD_LIST.emit(t,$2->loc,*($2->folder),ARR_IDX_ARG);
            QUAD_LIST.emit(t,t,"1",SUB); debug("err13");
            QUAD_LIST.emit($2->loc,t,*($2->folder),ARR_IDX_RES);
            $$->loc = GST->gentemp(GST->lookup($2->loc)->type.type2);debug("err14");
        }
        else
        {	debug("err16");
            QUAD_LIST.emit($2->loc,$2->loc,"1",SUB);
            $$->loc = GST->gentemp(GST->lookup($2->loc)->type.type); debug("err15");
        }debug("err17");
        QUAD_LIST.emit($$->loc,$2->loc,"",ASSIGN); 
	}
	| unary_operator cast_expression
	{	debug("err18");
		if($1 == '&')
        {
            $$ = new expression; 
            $$->loc = GST->gentemp(PTR);
           	debug("err19");
            QUAD_LIST.emit($$->loc,$2->loc,"",REFERENCE);
        }
        else if($1 == '*')
        {	debug("err20");
            $$ = new expression; 
            $$->loc = GST->gentemp(INT);
            $$->fold=1;debug("err21");
            
            $$->folder = new string($2->loc);
            debug("err22");
            QUAD_LIST.emit($$->loc,$2->loc,"",DEREFERENCE);
        }
        else if($1 == '-')
        {	debug("err23");
            $$ = new expression; 
            $$->loc = GST->gentemp();debug("err24");
            QUAD_LIST.emit($$->loc,$2->loc,"",U_MINUS);
        }
        else if($1 == '!')
        {	debug("err25");
            $$=new expression;
            $$->loc=GST->gentemp(INT);
            stringstream ss;debug("err26");
            int temp=QUAD_LIST.next_inst+2;
            ss << temp;debug("err27");
            QUAD_LIST.emit(ss.str(),$2->loc,"0",GOTO_EQ);
			debug("err28");
            temp=QUAD_LIST.next_inst+3;
            stringstream ss2;debug("err29");
            ss2 << temp;
            QUAD_LIST.emit(ss2.str(),"","",GOTO);
            debug("err30");
            QUAD_LIST.emit($$->loc,"1","",ASSIGN);
			debug("err31");
            stringstream ss3;
            temp=QUAD_LIST.next_inst+2;
            ss3 << temp;debug("err32");
			QUAD_LIST.emit(ss3.str(),"","",GOTO);
			debug("err33");
            QUAD_LIST.emit($$->loc,"0","",ASSIGN);
			debug("err34");
        }
	}
	| SIZEOF_KEY unary_expression {debug("err35");}
	{}
	| SIZEOF_KEY '(' type_name ')' {debug("err36");}
	{}
	;

unary_operator
	: '&'
	{
		$$='&';debug("err1");
	}
	| '*'
	{
		$$='*';debug("err2");
	}
	| '+'
	{
		$$='+';debug("err3");
	}
	| '-'
	{
		$$='-';debug("err4");
	}
	| '~'
	{
		$$='~';debug("err5");
	}
	| '!'
	{
		$$='!';debug("err6");
	}
	;

cast_expression
	: unary_expression
	{
		debug("err1");
	}
	| '(' type_name ')' cast_expression {debug("err2");}
	{

	}
	;

multiplicative_expression
	: cast_expression
	{
		$$=new expression;
		debug("err1");
		symbol_type t1 = GST->lookup($1->loc)->type;
        if(t1.type == ARRAY)
        {

        	debug("err2");
            string t = GST->gentemp(t1.type2);
            debug("err");
            if($1->folder!=NULL)
            {
	            debug("err3");
	            QUAD_LIST.emit(t,$1->loc,*($1->folder),ARR_IDX_ARG);
	            debug("err4");

	            $1->loc = t; 
	            $1->type = t1.type2;
	            $$=$1;debug("err5");
	        }
	        else
	        	$$=$1;
			debug("err6");
         
            
        }
        else
        {
        	debug("err7");
            $$ = $1;
        }
           debug("err8");
	}
	| multiplicative_expression '*' cast_expression
	{	debug("err9");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err10");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err11");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err12");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err13");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err14");
			$1->type=one->type.type2;
		}

		Types final;
		debug("err15");
		if(one->type.type > two->type.type)
		{	debug("err16");
			final=one->type.type;
		}
		else
		{	debug("err17");
			final=two->type.type;			
		}
			
		debug("err18");
		$$->loc=GST->gentemp(final);
		QUAD_LIST.emit($$->loc,$1->loc,$3->loc,MULT);
		debug("err19");

	}
	| multiplicative_expression '/' cast_expression
	{	debug("err20");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err21");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err22");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err23");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err24");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err25");
			$1->type=one->type.type2;
		}

		Types final;
		debug("err26");
		if(one->type.type > two->type.type)
		{	debug("err27");
			final=one->type.type;
		}
		else
		{	debug("err28");
			final=two->type.type;			
		}
			
		
		$$->loc=GST->gentemp(final);debug("err29");
		QUAD_LIST.emit($$->loc,$1->loc,$3->loc,DIV);
	}
	| multiplicative_expression '%' cast_expression
	{
		$$=new expression();debug("err30");
		sym_tab_row *one=GST->lookup($1->loc);debug("err31");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err32");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err33");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err34");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err35");
			$1->type=one->type.type2;
		}

		Types final;
		debug("err36");
		if(one->type.type > two->type.type)
		{	debug("err37");
			final=one->type.type;
		}
		else
		{	debug("err38");
			final=two->type.type;			
		}
			
		debug("err39");
		$$->loc=GST->gentemp(final);
		QUAD_LIST.emit($$->loc,$1->loc,$3->loc,MOD);debug("err40");
	}
	;

additive_expression
	: multiplicative_expression {debug("err1");}
	| additive_expression '+' multiplicative_expression
	{	debug("err2");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("er3");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err4");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err5");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err6");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err7");
			$1->type=one->type.type2;
		}

		Types final;
		debug("err8");
		if(one->type.type > two->type.type)
		{	debug("err9");
			final=one->type.type;
		}
		else
		{	debug("err10");
			final=two->type.type;			
		}
			
		debug("err11");
		$$->loc=GST->gentemp(final);debug("err12");
		QUAD_LIST.emit($$->loc,$1->loc,$3->loc,ADD);
	}
	| additive_expression '-' multiplicative_expression
	{	debug("err13");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err14");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err15");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err16");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err17");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err18");
			$1->type=one->type.type2;
		}

		Types final;
		debug("err19");
		if(one->type.type > two->type.type)
		{	debug("err20");
			final=one->type.type;
		}
		else
		{	debug("err21");
			final=two->type.type;			
		}
			
		debug("err22");
		$$->loc=GST->gentemp(final);
		QUAD_LIST.emit($$->loc,$1->loc,$3->loc,SUB);debug("err23");
	}
	;

shift_expression
	: additive_expression {debug("err1");}
	| shift_expression LEFT_SHIFT additive_expression
	{	debug("err2");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err3");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err4");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err5");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err6");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err7");
			$1->type=one->type.type2;
		}
		debug("err8");
		$$->loc=GST->gentemp(one->type.type);
		QUAD_LIST.emit($$->loc,$1->loc,$3->loc,SL);
	}
	| shift_expression RIGHT_SHIFT additive_expression
	{	debug("err9");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);
		sym_tab_row *two=GST->lookup($3->loc);
		debug("err10");
		if(two->type.type==ARRAY)
		{	debug("err11");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err12");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err13");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err14");
			$1->type=one->type.type2;
		}
		debug("err15");
		$$->loc=GST->gentemp(one->type.type);debug("err16");
		QUAD_LIST.emit($$->loc,$1->loc,$3->loc,SR);
	}
	;

relational_expression
	: shift_expression {debug("err17");}
	| relational_expression '<' shift_expression
	{	debug("err18");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err19");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err20");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err21");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err22");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err23");
			$1->type=one->type.type2;
		}
		debug("err24");
		$$ = new expression; 
        $$->loc = GST->gentemp();
        $$->type = BOOL; debug("err25");
        QUAD_LIST.emit($$->loc,"1","",ASSIGN); 
        $$->TL = makelist(QUAD_LIST.next_inst); debug("err26");
        QUAD_LIST.emit("",$1->loc,$3->loc,GOTO_LT); 
        QUAD_LIST.emit($$->loc,"0","",ASSIGN);  
        $$->FL = makelist(QUAD_LIST.next_inst); debug("err27");
        QUAD_LIST.emit("","","",GOTO);
	}
	| relational_expression '>' shift_expression
	{	debug("err28");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err29");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err30");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err31");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err32");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err33");
			$1->type=one->type.type2;
		}
		debug("err34");
		$$ = new expression; 
        $$->loc = GST->gentemp();
        $$->type = BOOL; debug("err35");
        QUAD_LIST.emit($$->loc,"1","",ASSIGN); 
        $$->TL = makelist(QUAD_LIST.next_inst); debug("err36");
        QUAD_LIST.emit("",$1->loc,$3->loc,GOTO_GT); 
        QUAD_LIST.emit($$->loc,"0","",ASSIGN);  debug("err37");
        $$->FL = makelist(QUAD_LIST.next_inst); debug("err38");
        QUAD_LIST.emit("","","",GOTO);debug("err39");
	}
	| relational_expression LESS_THAN_EQUAL shift_expression
	{	debug("err40");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err41");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err42");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err43");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err44");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err45");
			$1->type=one->type.type2;
		}
		debug("err46");
		$$ = new expression; 
        $$->loc = GST->gentemp();
        $$->type = BOOL; 	debug("err47");
        QUAD_LIST.emit($$->loc,"1","",ASSIGN); 
        $$->TL = makelist(QUAD_LIST.next_inst); debug("err48");
        QUAD_LIST.emit("",$1->loc,$3->loc,GOTO_LTE); 
        QUAD_LIST.emit($$->loc,"0","",ASSIGN);  
        $$->FL = makelist(QUAD_LIST.next_inst); debug("er49r");
        QUAD_LIST.emit("","","",GOTO);
	}
	| relational_expression GREATER_THAN_EQUAL shift_expression
	{	debug("err50");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err51");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err52");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err53");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err54");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err55");
			$1->type=one->type.type2;
		}

		$$ = new expression; debug("err56");
        $$->loc = GST->gentemp();
        $$->type = BOOL; debug("err57");
        QUAD_LIST.emit($$->loc,"1","",ASSIGN); 
        $$->TL = makelist(QUAD_LIST.next_inst); debug("err58");
        QUAD_LIST.emit("",$1->loc,$3->loc,GOTO_GTE); 
        QUAD_LIST.emit($$->loc,"0","",ASSIGN);  
        $$->FL = makelist(QUAD_LIST.next_inst); 
        QUAD_LIST.emit("","","",GOTO);debug("err59");
	}
	;

equality_expression
	: relational_expression
	{	debug("err1");
		$$=new expression;
		$$=$1;debug("err2");
	}
	| equality_expression EQUAL_EQUAL relational_expression
	{	debug("err3");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err4");
		sym_tab_row *two=GST->lookup($3->loc);
		debug("err6");
		if(two->type.type==ARRAY)
		{	debug("err5");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err7");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)	
		{	debug("err8");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err9");
			$1->type=one->type.type2;
		}
		debug("err10");
		$$ = new expression; 
        $$->loc = GST->gentemp();
        $$->type = BOOL; debug("err11");
        QUAD_LIST.emit($$->loc,"1","",ASSIGN); 
        $$->TL = makelist(QUAD_LIST.next_inst);debug("err12");
        QUAD_LIST.emit("",$1->loc,$3->loc,GOTO_EQ); 
        QUAD_LIST.emit($$->loc,"0","",ASSIGN);  debug("err13");
        $$->FL = makelist(QUAD_LIST.next_inst); 
        QUAD_LIST.emit("","","",GOTO);debug("err14");
	}
	| equality_expression NOT_EQUAL relational_expression
	{	debug("err15");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err16");
		sym_tab_row *two=GST->lookup($3->loc);

		if(two->type.type==ARRAY)
		{	debug("err17");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;	debug("err18");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err19");
			$1->type=one->type.type2;
		}
		debug("err20");
		$$ = new expression; 
        $$->loc = GST->gentemp();
        $$->type = BOOL; debug("err21");
        QUAD_LIST.emit($$->loc,"1","",ASSIGN); 
        $$->TL = makelist(QUAD_LIST.next_inst); debug("err22");
        QUAD_LIST.emit("",$1->loc,$3->loc,GOTO_NEQ); 
        QUAD_LIST.emit($$->loc,"0","",ASSIGN);  debug("err23");
        $$->FL = makelist(QUAD_LIST.next_inst); 
        QUAD_LIST.emit("","","",GOTO);debug("err24");
	}
	;

and_expression
	: equality_expression
	{
		debug("err1");
	}
	| and_expression '&' equality_expression
	{	debug("err");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err2");
		sym_tab_row *two=GST->lookup($3->loc);
		debug("err3");
		if(two->type.type==ARRAY)	
		{	debug("err4");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err5");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err6");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err7");
			$1->type=one->type.type2;
		}
		debug("err8");
		$$ = new expression; 
        $$->loc = GST->gentemp();debug("err9");
       	QUAD_LIST.emit($$->loc,$1->loc,$3->loc,BW_AND);
	}
	;

exclusive_or_expression
	: and_expression
	{
		debug("err1");$$=$1;	
	}
	| exclusive_or_expression '^' and_expression
	{
		debug("err2");
		$$=new expression();
		sym_tab_row *one=GST->lookup($1->loc);debug("err3");
		sym_tab_row *two=GST->lookup($3->loc);
		debug("err4");
		if(two->type.type==ARRAY)
		{	debug("err5");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err6");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err7");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;debug("err8");
			$1->type=one->type.type2;
		}
		debug("err9");
		$$ = new expression; 
        $$->loc = GST->gentemp();debug("err10");
       	QUAD_LIST.emit($$->loc,$1->loc,$3->loc,BW_XOR);
	}
	;

inclusive_or_expression
	: exclusive_or_expression
	{	debug("err1");
		$$=new expression;
		$$=$1;debug("err2");
	}
	| inclusive_or_expression '|' exclusive_or_expression
	{
		$$=new expression();debug("err3");
		sym_tab_row *one=GST->lookup($1->loc);debug("err4");
		sym_tab_row *two=GST->lookup($3->loc);
		debug("err5");
		if(two->type.type==ARRAY)
		{	debug("err6");
			string temp=GST->gentemp(two->type.type2);
			QUAD_LIST.emit(temp,$3->loc,*($3->folder),ARR_IDX_ARG);
			$3->loc=temp;debug("err7");
			$3->type=two->type.type2;
		}

		if(one->type.type==ARRAY)
		{	debug("err8");
			string temp=GST->gentemp(one->type.type2);
			QUAD_LIST.emit(temp,$1->loc,*($1->folder),ARR_IDX_ARG);
			$1->loc=temp;	debug("err9");
			$1->type=one->type.type2;
		}
		debug("err10");
		$$ = new expression; 
        $$->loc = GST->gentemp();debug("err11");
       	QUAD_LIST.emit($$->loc,$1->loc,$3->loc,BW_OR);debug("err12");
	}
	;

logical_and_expression
	: inclusive_or_expression
	{debug("err13");
	}
	| logical_and_expression LOGICAL_AND M inclusive_or_expression
	{	debug("err14");
		QUAD_LIST.backpatch($1->TL,$3->instr);
		$$->FL=merge($1->FL,$4->FL);debug("err15");
		$$->TL=$4->TL;
		$$->type=BOOL;debug("err16");
	}
	;

logical_or_expression
	: logical_and_expression
	{	debug("err17");
	}
	| logical_or_expression LOGICAL_OR M logical_and_expression
	{	debug("err18");
		QUAD_LIST.backpatch($1->FL,$3->instr);
		$$->TL=merge($1->TL,$4->TL);
		$$->FL=$4->FL;debug("err19");
		$$->type=BOOL;
	}
	;

conditional_expression
	: logical_or_expression
	{	debug("err20");
		$$=$1;
	}
	| logical_or_expression N '?' M expression N ':' M conditional_expression
	{	debug("err21");
		sym_tab_row* one=GST->lookup($5->loc);
		$$->loc=GST->gentemp(one->type.type);
		$$->type=one->type.type;debug("err22");
		QUAD_LIST.emit($$->loc,$9->loc,"",ASSIGN);
		list<int> temp=makelist(QUAD_LIST.next_inst);
		QUAD_LIST.emit("","","",GOTO);debug("err23");
		QUAD_LIST.backpatch($6->NL,QUAD_LIST.next_inst);
		QUAD_LIST.emit($$->loc,$5->loc,"",ASSIGN);debug("err24");
		temp=merge(temp,makelist(QUAD_LIST.next_inst));
		QUAD_LIST.emit("","","",GOTO);debug("err25");
		QUAD_LIST.backpatch($2->NL,QUAD_LIST.next_inst);
		QUAD_LIST.convInttoBool($1);debug("err26");
		QUAD_LIST.backpatch($1->TL,$4->instr);
		QUAD_LIST.backpatch($1->FL,$8->instr);debug("err27");
		QUAD_LIST.backpatch($2->NL,QUAD_LIST.next_inst);
	}
	;

assignment_expression
	: conditional_expression
	{	
		debug("err1");
	}
	| unary_expression assignment_operator assignment_expression
	{
		debug("err2");
		sym_tab_row *temp=GST->lookup($3->loc);
		debug("err3");
		sym_tab_row *temp1=GST->lookup($1->loc);
		if($1->fold==0)
		{	debug("err4");
			if(temp1->type.type != ARRAY)
			{
				debug("err5");
				QUAD_LIST.emit($1->loc,$3->loc,"",ASSIGN);
			}
			else
			{
				debug("err6");
				QUAD_LIST.emit($1->loc,$3->loc,*($1->folder),ARR_IDX_RES);
			}
		}
		else
		{
			debug("err7");
			QUAD_LIST.emit(*($1->folder),$3->loc,"",L_DEREF);
		}
		$$=$1;debug("err8");
	}
	;

assignment_operator
	: '='
	{debug("err");}
	|MULTIPLY_EQUAL
	{debug("err1");}
	|DIVIDE_EQUAL
	{debug("err2");}
    |MODULO_EQUAL
    {debug("err3");}
    |PLUS_EQUAL
    {debug("err4");}
    |MINUS_EQUAL
    {debug("err5");}
    |LEFT_SHIFT_EQUAL
    {debug("err6");}
    |RIGHT_SHIFT_EQUAL
    {debug("err7");}
    |AND_EQUAL
    {debug("err8");}
    |BITWISENOT_EQUAL
    {debug("err9");}
    |OR_EQUAL
    {debug("err10");}
	;

expression
	: assignment_expression
	{	debug("err1");
	}
	| expression ',' assignment_expression
	{debug("err2");}
	;	

constant_expression
	: conditional_expression
	{}
	;

declaration
	: declaration_specifiers init_declarator_list ';'
	{	debug("err1");
		Types curr_type=$1;
		int curr_size=-1;	
		if(curr_type==INT){debug("err2");
			curr_size=size_of_int;}
		else if(curr_type==CHAR){debug("err3");
			curr_size=size_of_char;}
		else if(curr_type==DOUBLE){
			curr_size=size_of_double;debug("err4");}
		vector<declarations*> list=*($2);
		debug("err5");
		for (vector<declarations*>::iterator it = list.begin(); it != list.end(); ++it)
		{
			declarations *curr_dec=*it;
			debug("err6");
			if(curr_dec->type == FUNCTION)
			{	debug("err7");
				GST=&(gst);
				QUAD_LIST.emit(curr_dec->name,"","",FUNC_END);
				debug("err8");
				sym_tab_row *one=GST->lookup(curr_dec->name);
				sym_tab_row *two=one->nested_table->lookup("RETVAL",curr_type,curr_dec->pointers);debug("err10");
				one->size=0;
				debug("err9");
				one->init_val=NULL;
				continue;
			}

			sym_tab_row *three=GST->lookup(curr_dec->name,curr_type);
			three->nested_table=NULL;	debug("err11");
			if(curr_dec->list == vector<int>() && curr_dec->pointers == 0) 
            {	debug("err12");
                three->type.type = curr_type;
                debug("err13");
                three->size = curr_size;
                if(curr_dec->init_val != NULL)
                {	debug("err14");
                    string rval = curr_dec->init_val->loc;
                    QUAD_LIST.emit(three->name, rval,"",ASSIGN);debug("err15");
                    three->init_val = GST->lookup(rval)->init_val;
                }
                else
                    three->init_val = NULL;
            }
            else if(curr_dec->list!=vector<int>())
            {	debug("err1");
                three->type.type = ARRAY;
                three->type.type2 = curr_type;debug("err17");
                three->type.dims = curr_dec->list;
                debug("err18");
                int sz = curr_size; vector<int> tmp = three->type.dims; int tsz = tmp.size();debug("err19");
                for(int i = 0; i<tsz; i++) sz *= tmp[i];
                    GST->offset += sz;
                debug("err20");
                three->size = sz;
                GST->offset-=4;debug("err21");
            }
            else if(curr_dec->pointers != 0)
            {	debug("err22");
                three->type.type = PTR;
                three->type.type2 = curr_type;debug("err23");
                three->type.pointers = curr_dec->pointers;
                debug("err24");
                GST->offset += size_of_pointer - curr_size;
                three->size = size_of_pointer;debug("err25");
            }
		}
		
	}
	| declaration_specifiers ';' {debug("err26");}
	;



declaration_specifiers
	 : storage_class_specifier
	 {debug("err1");}
    | storage_class_specifier declaration_specifiers
    {debug("err2");}
    | type_specifier
    {debug("err3");}                               
    | type_specifier declaration_specifiers
    {debug("err4");}
    | type_qualifier
    {debug("err6");}
    | type_qualifier declaration_specifiers
    {debug("err5");}
    | function_specifier
    {debug("err4");}
    | function_specifier declaration_specifiers
    {debug("err40");}
    ;



init_declarator_list
	: init_declarator
	{
		debug("err1");
		$$ = new vector<declarations*>;
		$$->pb($1);debug("err2");
	}
	| init_declarator_list ',' init_declarator
	{	debug("err3");
		$1->pb($3);
		$$=$1;
	}
	;

init_declarator
	: declarator
	{
		$$=$1;debug("err2");
		$$->init_val=NULL;
	}
	| declarator '=' initializer
	{	debug("err2");
		$$=$1;
		$$->init_val=$3;debug("err3");
	}
	;
storage_class_specifier
	:TYPEDEF_KEY
	{debug("err1");}
	| EXTERN_KEY
	{debug("err2");}
	| STATIC_KEY
	{debug("err3");}
	| AUTO_KEY
	{debug("err4");}
	| REGISTER_KEY
	{debug("err5");}
	;

type_specifier
	: VOID_KEY
	{	debug("err2");
		$$=VOID;
	}
	| CHAR_KEY
	{	debug("err1");
		$$=CHAR;
	}
	| SHORT_KEY
	{}
	| INT_KEY
	{	debug("er3");
		$$=INT;
	}
	| LONG_KEY
	{debug("err4");}
	| FLOAT_KEY
	{debug("err5");}
	| DOUBLE_KEY
	{	debug("err6");
		$$=DOUBLE;
	}
	| SIGNED_KEY
	{debug("err7");}
	| UNSIGNED_KEY
	{debug("err8");}
	| BOOL_KEY
	{debug("err9");}
	| COMPLEX_KEY
	{debug("er10");}
	| IMAGINARY_KEY
	{debug("err11");}
	| enum_specifier
	{debug("err12");}
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list_opt
	{debug("er11r");}
	| type_qualifier specifier_qualifier_list_opt
	{debug("err2");}
	;

specifier_qualifier_list_opt
	: specifier_qualifier_list
	{debug("err1");}
	|
	{debug("err2");}
	;

enum_specifier
	: ENUM_KEY '{' enumerator_list '}'
	{debug("err1");}
	| ENUM_KEY IDENTIFIER '{' enumerator_list '}'
	{debug("err2");}
	| ENUM_KEY '{' enumerator_list ',' '}'
	{debug("err3");}
	| ENUM_KEY IDENTIFIER '{' enumerator_list ',' '}'
	{debug("err4");}
	| ENUM_KEY IDENTIFIER
	{debug("err");}
	;

enumerator_list
	: enumerator
	{debug("err1");}
	| enumerator_list ',' enumerator
	{debug("err2");}
	;

enumerator
	: ENUMERATION
	{debug("err1");}
	| ENUMERATION '=' constant_expression
	{debug("err2");}
	;

type_qualifier
	: CONST_KEY
	{debug("err1");}
	| RESTRICT_KEY
	{debug("err2");}
	| VOLATILE_KEY
	{debug("err3");}
	;

function_specifier
	: INLINE_KEY
	{debug("err");}
	;

declarator
	: pointer direct_declarator
	{	debug("err1");
		$$=$2;
		$$->pointers=$1;debug("err2");
	}
	| direct_declarator
	{	debug("err3");
		$$=$1;
		$$->pointers=0;debug("err4");
	}
	;


direct_declarator
	: IDENTIFIER
	{		debug("err4");
		$$=new declarations;
		$$->name=*($1);debug("err4");
	}
	| '(' declarator ')'
	{debug("err4");}
	| direct_declarator '[' type_qualifier_list_opt ']'
	{
		debug("err4");
		
		$1->type=ARRAY;
		$1->type2=INT;
		$$=$1;debug("err4");
		int index;
		index=0;debug("err4");
		$$->list.pb(index);
		debug("err4");
	}
	| direct_declarator '[' type_qualifier_list_opt assignment_expression ']'
	{
		debug("err4");
		
		$1->type=ARRAY;
		$1->type2=INT;debug("err4");
		$$=$1;
		int index;debug("err4");
		 index=GST->lookup($4->loc)->init_val->a;
		$$->list.pb(index);
		debug("err4");
	}
	| direct_declarator '[' STATIC_KEY type_qualifier_list_opt assignment_expression ']'
	{
		debug("err4");
	}
	| direct_declarator '[' type_qualifier_list STATIC_KEY assignment_expression ']'
	{debug("err4");}	
	| direct_declarator '[' type_qualifier_list_opt '*' ']'
	{	debug("err4");
		$1->type=PTR;
		$1->type2=INT;
		$$=$1;
	}
	| direct_declarator '(' parameter_type_list_opt ')'
	{
		debug("err4");
		$$ = $1;

        $$->type = FUNCTION;debug("err4");
        sym_tab_row *function_data = GST->lookup($$->name,$$->type);
        sym_tab *function_sym_tab = new sym_tab;debug("err4");
        function_data->nested_table = function_sym_tab;
       vector<param*> param_list=*($3);	debug("err4");
        for(int i = 0;i<param_list.size(); i++)		
        {	debug("err4");
            param *curr_param = param_list[i];
            if(curr_param->type.type==ARRAY)
            {	debug("err4");
            	//cerr << "array was entered\n";
				function_sym_tab->lookup(curr_param->name,curr_param->type.type);debug("err4");
				function_sym_tab->lookup(curr_param->name)->type.type2=INT;debug("err4");
				function_sym_tab->lookup(curr_param->name)->type.dims.pb(0);debug("err4");
            }
            else if(curr_param->type.type==PTR)
            {	debug("err4");
            	cerr << "pointer was made\n";debug("err4");
            	function_sym_tab->lookup(curr_param->name,curr_param->type.type);debug("err4");
				function_sym_tab->lookup(curr_param->name)->type.type2=INT;debug("err4");
				function_sym_tab->lookup(curr_param->name)->type.dims.pb(0);
            }
			else
				function_sym_tab->lookup(curr_param->name,curr_param->type.type);
        }
        debug("err4");
        GST = function_sym_tab;debug("err4");
        QUAD_LIST.emit($$->name,"","",FUNC_BEG);
		debug("err4");
	}
	| direct_declarator '(' identifier_list ')'
	{debug("err4");}
	;
parameter_type_list_opt
	:
	{	debug("err4");
		$$ =new vector <param*>;
	}
	| parameter_type_list
	{debug("err4");}
	;

pointer
	: '*' type_qualifier_list
	{debug("err");}
	| '*'
	{
		$$=1;debug("err");
	}
	| '*' type_qualifier_list pointer
	{debug("err");}
	| '*' pointer
	{	debug("err");
		$$=1+$2; 
	}
	;

type_qualifier_list_opt
	: type_qualifier_list
	{debug("err");}
	|
	{debug("err");}
	;

type_qualifier_list
	: type_qualifier
	{debug("err");}
	| type_qualifier_list type_qualifier
	{debug("err");}
	;


parameter_type_list
	: parameter_list
	
	| parameter_list ',' ELLIPSES
	
	;

parameter_list
	: parameter_declaration
	{	debug("err");
		$$ = new vector<param*>; 
		$$->push_back($1);
	}
	| parameter_list ',' parameter_declaration
	{	debug("err");
		$1->push_back($3);
		 $$ = $1;
	}
	;

parameter_declaration
	: declaration_specifiers declarator
	{
		$$=new param;debug("err");
		$$->name=$2->name;
		if($2->type==ARRAY)
		{
			debug("err");
			$$->type.type=ARRAY;
			$$->type.type2=$1;
		}
		else if($2->pc!=0)
		{	debug("err");
			$$->type.type=PTR;
			$$->type.type2=$1;
		}
		else
		{	debug("err");
			$$->type.type=$1;
		}
	}
	| declaration_specifiers
	{debug("err");}
	;

identifier_list
	: IDENTIFIER
	{debug("err");}
	| identifier_list ',' IDENTIFIER
	{debug("err");}
	;

type_name
	: specifier_qualifier_list
	{debug("err");}
	;

initializer
	: assignment_expression
	{	debug("err");
		$$=$1;
	}
	| '{' initializer_list '}'
	{debug("err");}
	| '{' initializer_list ',' '}'
	{debug("err");}
	;

initializer_list
	: designation_opt initializer
	{debug("err");}
	| initializer_list ',' designation_opt initializer
	{debug("err");}
	;

designation_opt
	: designation
	{debug("err");}
	|
	{debug("err");}
	;

designation
	: designator_list '='
	{debug("err");}
	;

designator_list
	: designator
	{debug("err");}
	| designator_list designator
	{debug("err");}
	;

designator
	: '[' constant_expression ']'
	{debug("err");}
	| '.' IDENTIFIER
	{debug("err");}
	;

statement
	: labeled_statement
	{debug("err");debug("err");}
		| compound_statement
		| expression_statement
		| selection_statement
		| iteration_statement
		| jump_statement
		;

labeled_statement
	: IDENTIFIER ':' statement
	{debug("err");}
	| CASE_KEY constant_expression ':' statement
	{debug("err");}
	| DEFAULT_KEY ':' statement
	{debug("err");}
	;

compound_statement
	: '{' '}'
	{debug("err");}
	| '{' block_item_list '}'
	{	debug("err");
		$$=$2;
	}
	;

block_item_list
	: block_item
	{	debug("err");
		$$=$1;
		QUAD_LIST.backpatch($1->NL,QUAD_LIST.next_inst);
	}
	| block_item_list M block_item
	{	debug("err");
		$$ = new expression;
		QUAD_LIST.backpatch($1->NL,$2->instr);
		$$->NL=$3->NL;
	}
	;

block_item
	: declaration
	{	debug("err");
		$$ = new expression;

	}
	| statement
	
	;

expression_statement
	: ';'
	{
		$$=new expression;
	}
	| expression ';'
	{
		//$$=$1;
	}
	;

selection_statement
	: IF_KEY '(' expression N ')' M statement N
	{	debug("err");
		QUAD_LIST.backpatch($4->NL,QUAD_LIST.next_inst);
		QUAD_LIST.convInttoBool($3);debug("err");
		QUAD_LIST.backpatch($3->TL,$6->instr);
		$$ = new expression;debug("err");
		$7->NL=merge($8->NL,$7->NL);
		$$->NL=merge($3->FL,$7->NL);debug("err");

	}
	| IF_KEY '(' expression N ')' M statement N ELSE_KEY  M statement N
	{	debug("err");
		QUAD_LIST.backpatch($4->NL,QUAD_LIST.next_inst);
        QUAD_LIST.convInttoBool($3);debug("err");
        QUAD_LIST.backpatch($3->TL,$6->instr);
        QUAD_LIST.backpatch($3->FL,$10->instr);
        $$ = new expression;debug("err");
        $$->NL = merge($7->NL,$8->NL);        
        $$->NL = merge($$->NL,$11->NL);  debug("err");
        $$->NL=merge($$->NL,$12->NL); 
	}
	| SWITCH_KEY '(' expression ')' statement
	{
		debug("err");
	}
	;

iteration_statement
	: WHILE_KEY M '(' expression N ')' M statement
	{
		debug("err");
		$$ = new expression;
		
		debug("err");
		QUAD_LIST.emit("","","",GOTO);
		QUAD_LIST.backpatch(makelist(QUAD_LIST.next_inst-1),$2->instr);debug("err");
		QUAD_LIST.backpatch($5->NL,QUAD_LIST.next_inst);
		QUAD_LIST.convInttoBool($4);debug("err");
		$$->NL=$4->FL;
		debug("err");
		QUAD_LIST.backpatch($4->TL,$7->instr);
		QUAD_LIST.backpatch($8->NL,$2->instr);debug("err");
	}
	| DO_KEY M statement M WHILE_KEY '(' expression N ')' ';'
	{	debug("err");
		$$=new expression;
		QUAD_LIST.backpatch($8->NL,QUAD_LIST.next_inst);debug("err");
		QUAD_LIST.convInttoBool($7);debug("err");
		QUAD_LIST.backpatch($7->TL,$2->instr);
		QUAD_LIST.backpatch($3->NL,$4->instr);debug("err");
		$$->NL=$7->FL;debug("err");
	}
	| FOR_KEY '(' expression_statement M expression_statement N M expression N ')' M statement
	{
		$$=new expression;
		debug("err");
		QUAD_LIST.emit("","","",GOTO);debug("err");
		$12->NL=merge($12->NL,makelist(QUAD_LIST.next_inst-1));debug("err");
		QUAD_LIST.backpatch($12->NL,$7->instr);debug("err");
		QUAD_LIST.backpatch($9->NL,$4->instr);
		QUAD_LIST.backpatch($6->NL,QUAD_LIST.next_inst);debug("err");
		QUAD_LIST.convInttoBool($5);debug("err");
		QUAD_LIST.backpatch($5->TL,$11->instr);
		$$->NL=$5->FL;debug("err");
	}
	;



jump_statement
	: GOTO_KEY IDENTIFIER ';'
	{debug("err");}
	| CONTINUE_KEY ';'
	{debug("err");}
	| BREAK_KEY ';'
	{debug("err");}
	| RETURN_KEY ';'
	{	debug("err");
		if(GST->lookup("RETVAL")->type.type==VOID)
			QUAD_LIST.emit("","","",RETURN);
		else
			debug("err");
		$$=new expression;debug("err");
	}
	| RETURN_KEY expression ';'
	{	debug("err");
		if(GST->lookup("RETVAL")->type.type == GST->lookup($2->loc)->type.type)
        {	debug("err");
            QUAD_LIST.emit($2->loc,"","",RETURN);
        }
        $$ =new expression;debug("err");
	}
	;

translation_unit
    : external_declaration
    {
    debug("err");
    }
    | translation_unit external_declaration
    {
    debug("err");
    }
    ;

external_declaration
    : function_definition
    {
    debug("err");
    }
    | declaration
    {
    	debug("err");
    }
    ;

function_definition
    : declaration_specifiers declarator declaration_list compound_statement
    {
    debug("err");
    }
    | function_prototype compound_statement
    {
    	debug("err");
        GST = &(gst);
        QUAD_LIST.emit($1->name,"","",FUNC_END);
    }
    
    ;

declaration_list
    :declaration
    {
   debug("err");
    }
    |declaration_list declaration
    {
   debug("err");
    }
    ;


N
	:                                              
	{	debug("err");
		$$ =  new expression;  
		$$->NL = makelist(QUAD_LIST.next_inst); debug("err");
		QUAD_LIST.emit("","","",GOTO);
	}
	;

// M is introduced to be a marker for an entry point to starting of parsed Quad code
M
	:                                                   
	{		debug("err");
		$$ =  new expression; 
		$$->instr = QUAD_LIST.next_inst;debug("err");
	}
	;


function_prototype
    :declaration_specifiers declarator
    {
       debug("err");
        Types curr_type = $1;
        int curr_size = -1;debug("err");
        if(curr_type == CHAR) curr_size = size_of_char;
        if(curr_type == INT)  curr_size = size_of_int;debug("err");
        if(curr_type == DOUBLE)  curr_size = size_of_double;        
        	debug("err");
        declarations *curr_dec = $2;debug("err");
        sym_tab_row *three = gst.lookup(curr_dec->name);
        if(curr_dec->type == FUNCTION) 
        {	debug("err");
            sym_tab_row *retval = three->nested_table->lookup("RETVAL",curr_type,curr_dec->pointers);
            
            debug("err");
            three->size = 0;
            three->init_val = NULL;           
        }debug("err");
        $$ = $2;
    }
    ;
%%

void yyerror(string s) {
	debug("err");
}

int main(int argc, char* argv[])
{
  debug("err");
    bool failure = yyparse();  
    int sz = QUAD_LIST.list_of_quads.size();
    ostringstream str1; 
  
    debug("err");
    str1 << argv[argc-1]; 
  
    debug("err");
    string inputfile = str1.str(); 
    inputfile = "quad_list"+inputfile+".out";

    ofstream outputfile;
    outputfile.open(inputfile);

    for(int i = 0; i<sz;i++)
    {
        outputfile<<i<<": "; QUAD_LIST.list_of_quads[i].print_quad(outputfile);
    }
    

    debug("err");
    outputfile<<"----------------SYMBOL TABLE----------------"<<endl;
    GST->print_symtab(outputfile);
    outputfile<<"--------------------------------------------"<<endl;
    for(map<string,sym_tab_row*> :: iterator it = GST->symbol_table.begin(); it != GST->symbol_table.end(); ++it)
    {	debug("err");
        sym_tab_row *tmp = it->second;
        if(tmp->nested_table != NULL)
        {	debug("err");
            outputfile<<"----------------SYMBOL TABLE ( "<<tmp->name<<" )----------------"<<endl;
            tmp->nested_table->print_symtab(outputfile);debug("err");
            outputfile<<"--------------------------------------------"<<endl;
        }
    }
    
    
    
    if(failure)
        outputfile<<"failure\n";
    else
        outputfile<<"success\n";
     

    GST=&gst;
    gencode(outputfile);
}
