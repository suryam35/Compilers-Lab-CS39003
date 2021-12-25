/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/


#ifndef TRANSLATE 
#define TRANSLATE
#include <iostream>
#include <ostream>
#include <list>
#include <string>
#include <vector>
#include <sstream> 
#include <algorithm>
#define size_of_char 		1
#define size_of_int  		4
#define size_of_float		8
#define size_of_pointer		4

#define debug(x) do { \
  if (gDebug) { cerr << x << std::endl; } \
} while (0)

extern  char* yytext;
extern  int yyparse();

using namespace std;


void debug_code();
/********* Forward Declarations ************/
class quads;
class boolexp;
class sym;						// Entry in a symbol table
class symtab;					// Symbol Table
class quad;


/************** Enum types *****************/
enum optype { EQUAL, BNOT, ADDRESS,  LNOT, UPLUS,LT, INOR,PTRL, PTRR,ARRR,GOTOOP, _RETURN, EQOP, BAND, XOR, GT,NEOP,ADD, SUB,GE, ARRL,PARAM,MODOP, MULT, DIVIDE, 
	RIGHTOP, LEFTOP,  LE, UMINUS,RIGHT_POINTER, CALL
};
enum type_e {	// Type enumeration
_VOID, _CHAR, _INT, PTR, ARR, FUNC, _FLOAT
	}; 	


/********** Class Declarations *************/

class symtype { // Type of an element in symbol table
public:
	symtype(type_e cat, symtype* ptr = NULL, int width = 1);
	type_e cat;
	int size;
	int width;					// Size of array
	symtype* ptr;				// Array -> array of ptr type; pointer-> pointer to ptr type 

public:
	friend ostream& operator<<(ostream&, const symtype);
};


class quad { // Individual Quad
public:
	quad (string result, int arg1, optype op = EQUAL, string arg2 = "");
	void print ();									// Print Quads
	void update (int addr);						// Used for backpatching address
	quad (string result, string arg1, optype op = EQUAL, string arg2 = "");
	void print_debug_quad();
	string result;				// Result
public:
	string arg1;				// Argument 1
	optype op;					// Operator
	string arg2;				// Argument 2
	string arg3;
};

class symtab { // Symbol Table
public:
	void print(int all = 0);					// Print the symbol table
	void computeOffsets();						// Compute offset of the whole symbol table recursively
	int tcount;					// Count of temporary variables
	list <sym> table; 			// The table of symbols
	int size;
public:
	string tname;				// Name of Table
	int width;
	symtab* parent;
	symtab (string name="");
	sym* lookup (string name);					// Lookup for a symbol in symbol table
	
};

sym* gentemp (type_e t=_INT, string init = "");	// Generate a temporary variable and insert it in symbol table



class sym { // Row in a Symbol Table
public:
	sym* update(symtype * t); 	// Update using type object and nested table pointer
	string init;				// Symbol initialisation
	string name;				// Name of symbol
	sym* initialize (string);
	int size;					// Size of the type of symbol
	int offset;					// Offset of symbol computed at the end
	sym* update(type_e t); 		// Update using raw type and nested table pointer
	string a;
	symtype *type;				// Type of Symbol
	string category;			// local, temp or global
	int width;
	symtab* nest;				// Pointer to nested symbol table

	sym (string, type_e t=_INT, symtype* ptr = NULL, int width = 0);
	
	friend ostream& operator<<(ostream&, const sym*);
	sym* linkst(symtab* t);
};

sym* gentemp (symtype* t, string init = "");	// Generate a temporary variable and insert it in symbol table
class quads { // Quad Array
public:
	vector <quad> array;		// Vector of quads
	vector <quad> array2;
	quads () {array.reserve(300);}
	void print ();								// Print all the quads
	void printtab();							// Print quads in tabular form
};


void emit(optype op, string result, int arg1, string arg2 = "");
void backpatch (list <int>, int);
void emit(optype opL, string result, string arg1="", string arg2 = "");


class Singleton {	// Global Symbol Table is Singleton Object
private:
   Singleton();
   static Singleton* pSingleton;					// singleton instance
public:
   static Singleton* GetInstance();
};
// Utility functions
template <typename T> string tostr(const T& t) { 
   ostringstream os; 
   ostringstream of;
   os<<t; 
   return os.str(); 
} 
/*********** Function Declarations *********/

						
void changeTable (symtab* newtable);
bool typecheck(sym* &s1, sym* &s2);					// Checks if two symbbol table entries have same type
bool typecheck(symtype* s1, symtype* s2);			// Check if the type objects are equivalent
string convert_to_string_debug (const symtype*);
int sizeoftype (symtype*);							// Calculate size of any type
string convert_to_string (const symtype*);			// For printing type structure
int sizeoftype_debug(symtype*);	

list<int> merge (list<int> &, list <int> &);		// Merge two lists
typedef list<int> lint;
list<int> makelist (int);	


string optostr(int);
sym* conv (sym*, symtype*);
string NumberToString(int);							// Converts a number to string mainly used for storing numbers
string optostr_debug(int);
sym* conv_debug(sym*, symtype*);
int nextinstr();									// Returns the address of the next instruction



/*** Global variables declared in cxx file****/
extern quads qarr;									// Quads
extern sym* currsym;								// Pointer to just encountered symbol
extern symtab* table;								// Current Symbbol Table
extern symtab* gTable;								// Global Symbbol Table

/** Attributes/Global for Boolean Expression***/

struct expr {
	sym* symp;			// Pointer to the symbol table entry
	// Valid for bool type
	lint falselist;		// Falselist valid for boolean expressions
	// Valid for statement expression
	lint nextlist;
	lint truelist;		// Truelist valid for boolean
	bool isbool;		// Boolean variable that stores if the expression is bool
	// Valid for non-bool type
};

struct statement {
	lint truelist;
	lint nextlist;		// Nextlist for statement
	lint falselist;
};

struct unary {
	sym* symp;			// Pointer to symbol table
	symtype* type;		// type of the subarray generated
	type_e cat;
	sym* loc;			// Temporary used for computing array address
};


void printlist (lint list);			// Print the list of integers
expr* convert2bool (expr*);			// convert any expression to bool
expr* convertfrombool (expr*);			// convert bool to expression

#endif
