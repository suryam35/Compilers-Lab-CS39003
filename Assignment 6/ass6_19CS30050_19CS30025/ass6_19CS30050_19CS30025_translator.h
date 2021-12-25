
/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    Header File
*/



#ifndef ASS6_19CS30050_19CS30025_TRANLATOR_H
#define ASS6_19CS30050_19CS30025_TRANLATOR_H
#include <bits/stdc++.h>
using namespace std;
#define pb push_back
#define size_of_int 4
#define size_of_char 1
#define size_of_double 8
#define size_of_pointer 8

typedef enum
{
	VOID,
	BOOL,
	CHAR,
	INT,
	DOUBLE,
	ARRAY,
	PTR,
	FUNCTION
}Types;

typedef enum 
{
	DEFAULT, ADD, SUB, MULT, DIV, MOD, SL, SR, LT, GT, EQ, NEQ, 
	LTE, GTE, LOG_AND, LOG_OR, BW_AND, BW_OR, BW_XOR, BW_U_NOT ,U_PLUS, U_MINUS, REFERENCE, DEREFERENCE, U_NEG, ASSIGN, GOTO_EQ,
	GOTO_NEQ, GOTO_GT, GOTO_GTE, GOTO_LT, GOTO_LTE, IF_GOTO,
	IF_FALSE_GOTO, CtoI, ItoC, DtoI, ItoD, DtoC ,CtoD, RETURN, PARAM, CALL, GOTO, ARR_IDX_ARG, ARR_IDX_RES, FUNC_END, FUNC_BEG, L_DEREF
}opcode;



class sym_tab;
class sym_tab_row;
class sym_value;
class symbol_type;
class expression;
class declaration;
class quads; 
class quad_array;


class sym_tab
{

public:
	sym_tab_row* lookup(string var,Types t=INT,int PC=0);
	sym_tab_row* lookup_mydebug(string var,Types t=INT,int PC=0);
	map<string,sym_tab_row*> symbol_table;
	sym_tab_row* look_in_global(string var);
	vector<sym_tab_row*> symbols;
	string gentemp(Types t=INT);
	int offset;
	void print_symtab(ofstream &outputfile);
	sym_tab()
	{offset=0;}
};

class quads
{
public:
	quads(string,string ,string,opcode);
	string arg2;
	string res;
	void print_quad(ofstream &outputfile);
	void print_quad_mydebug1(ofstream &outputfile);
	string arg1;
	opcode op;
	void print_quad();
	void print_quad_mydebug2();
};

class symbol_type
{
public:
	int pointers;
	Types type;
	vector<int> dims;
	Types type2;
};
list<int> merge(list<int> a,list<int> b);

class sym_tab_row
{
public:
	sym_tab_row()
	{
		nested_table=NULL;
	}
	string name;
	int size;
	symbol_type type;
	sym_value *init_val;
	int offset;
	sym_tab *nested_table;
	
};
list<int> makelist(int idx);



class sym_value
{
public:
	double c;
	void set_initial_value(int d)
	{
		a=b=c=d;
		p=NULL;
	}
	int a;
	void set_initial_value(char d)
	{
		a=b=c=d;
		p=NULL;
	}
	void *p;
	char b;
	void set_initial_value(double d)
	{
		a=b=c=d;
		p=NULL;
	}

};

class param
{
public:
	symbol_type type;
	string name;
};
void gencode(ofstream &outputfile);


class declarations
{
public:
	string name;
	int pointers;
	vector<int> list;
	expression *init_val;
	int pc;
	Types type;
	Types type2;
};



class expression
{
public:
	int instr;
	expression()
    {
        fold = 0;
        folder=NULL;
    }
	string *folder;
	int fold;  
	string loc;
	Types type;   
	list<int> TL,FL,NL;                                              
    
      
};
class quad_array
{
	public:
	vector<quads> list_of_quads;
	void convtotype(expression *arg,expression *res,Types type);
	int next_inst;
	void emit(string res,double constant,opcode U_op);
	quad_array(){next_inst=0;}
	void emit(string res,char constant,opcode U_op);
	void backpatch(list<int> dang,int idx);
	void emit(string result,string arg_1,string arg_2,opcode op);
	void convtotype(string t,Types to,string f,Types form);
	void emit(string res,int constant,opcode U_op);
	void convInttoBool(expression *res);
};





#endif /*ASS6_19CS30050_19CS30025_TRANLATOR_H */