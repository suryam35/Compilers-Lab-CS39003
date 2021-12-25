
/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    Translator file
*/


#include "ass6_19CS30050_19CS30025_translator.h"


void quads::print_quad(ofstream &outputfile)
{
	if(ADD<=op && op<=BW_XOR)
	{
		outputfile<<res<< " = " <<arg1;
		outputfile<<" ";
		switch(op)
		{
			case ADD: outputfile<<"+";					  
					  outputfile<<"";break; 
            case GTE: outputfile<<">="; 
					  outputfile<<"";break;
            case LOG_AND: outputfile<<"&&"; 
					  outputfile<<"";break;
			case NEQ: outputfile<<"!="; 
					  outputfile<<"";break;
            case SR: outputfile<<">>";   
					  outputfile<<"";break;
            case LT: outputfile<<"<"; 
					  outputfile<<"";break;
            case LOG_OR: outputfile<<"||"; 
					  outputfile<<"";break;
            case BW_XOR: outputfile<<"^"; 
					  outputfile<<"";break;
			case SUB: outputfile<<"-";
					  outputfile<<"";break;
            case LTE: outputfile<<"<="; 
					  outputfile<<"";break;
            case BW_OR: outputfile<<"|"; 
					  outputfile<<"";break;
            case DIV: outputfile<<"/"; 
					  outputfile<<"";break;
			case BW_AND: outputfile<<"&"; 
					  outputfile<<"";break;
            case MOD: outputfile<<"%"; 
					  outputfile<<"";break;
            case SL: outputfile<<"<<"; 
					  outputfile<<"";break;
			case MULT: outputfile<<"*"; 
					  outputfile<<"";break;
			case EQ: outputfile<<"=="; 
					  outputfile<<"";break;
            case GT: outputfile<<">"; 
					  outputfile<<"";break;    
		}
		outputfile<<" "<<arg2<<endl;
	}
	else if(BW_U_NOT <= op && op<=ASSIGN)
	{
		outputfile<<res<< " = ";
		switch(op)
		{
			case U_MINUS : outputfile<<"-";outputfile<<"";
			break; 
            case U_PLUS : outputfile<<"+";outputfile<<"";
			break;
            case BW_U_NOT : outputfile<<"~";outputfile<<""; 
			break;
            case U_NEG : outputfile<<"!";outputfile<<"";
			break;
            case ASSIGN : outputfile<<"";outputfile<<"";
			break;
			case REFERENCE : outputfile <<"&";outputfile<<"";
			break;
			case DEREFERENCE : outputfile <<"*";outputfile<<"";
		}
		outputfile << arg1 << endl;
	}
	else if(op==GOTO)
	{
		outputfile << "goto " << res << endl;
	}
	else if(GOTO_EQ<=op && op<=IF_FALSE_GOTO)
	{
		outputfile << "if "<< arg1;
		outputfile<<" ";
		switch(op)
		{
			case   GOTO_GT : outputfile<<"> ";outputfile<<"";
            break;
            case   IF_FALSE_GOTO : outputfile<<"== 0";outputfile<<"";
            break;
            case   GOTO_GTE : outputfile<<">= ";outputfile<<"";
            break;
            case   GOTO_EQ : outputfile<<"== ";outputfile<<"";
            break;
            case   GOTO_LT : outputfile<<"< ";outputfile<<"";
			break;
            case   IF_GOTO : outputfile<<"!= 0";outputfile<<""; 
            break;
            case   GOTO_LTE : outputfile<<"<= ";outputfile<<"";
            break;
            case   GOTO_NEQ : outputfile<<"!= ";outputfile<<""; 
            break;
            
		}
		outputfile<<arg2<< "goto "<<res;
		outputfile<<endl; 
	}
	else if(CtoI<=op && op<=CtoD)
	{
		outputfile<<res<<" = ";
        switch(op)
        {
            case CtoI : outputfile<<" ChartoInt("<<arg1;
            			outputfile<<")"<<endl;
            			break;
            case DtoC : outputfile<<" DoubletoChar("<<arg1;
            			outputfile<<")"<<endl; 
            			break;
            case ItoD : outputfile<<" InttoDouble("<<arg1; 
            			outputfile<<")"<<endl;
            			break;
            case ItoC : outputfile<<" InttoChar("<<arg1;
            			outputfile<<")"<<endl; 
            			break;
            case CtoD : outputfile<<" ChartoDouble("<<arg1; 
            			outputfile<<")"<<endl;
            			break;
            case DtoI : outputfile<<" DoubletoInt("<<arg1; 
            			outputfile<<")"<<endl;
            			break;
        }  
	}
	else if(op == PARAM)
	{
		outputfile << "param " << res << endl;
		outputfile<<endl;
	}
	else if(op == L_DEREF)
    {
    	outputfile << "*" << res << " = " << arg1;
    	outputfile<<endl;
    }
	else if(op==CALL)
	{
		if(arg2.size()>0)
			outputfile << arg2 << " = ";
		outputfile << "call " << res << " " << arg1;
		outputfile<<endl;
	}
	else if(op == FUNC_BEG)
    {
        outputfile << res << ": ";
        outputfile<<endl;
    }
    else if(op==RETURN)
	{
		outputfile << "return " << res;
		outputfile<<endl;
	}
   	else if(op == FUNC_END)
   	{
   		outputfile << "function " << res << " ends";
   		outputfile<<endl;
   	}
   	else if(op == DEREFERENCE)
    {
        outputfile<<res<<" = *"<<arg1;
        outputfile<<endl;
    }
	else if(op==ARR_IDX_ARG)
	{
		outputfile << res << " = " << arg1 << "[" << arg2 << "]";
		outputfile<<endl;
	}
	else if(op == REFERENCE)
    {
        outputfile<<res<<" = &"<<arg1;
        outputfile<<endl;
    }
	else if(op==ARR_IDX_RES)
	{
		outputfile << res << "[" << arg2 << "] = " << arg1;
		outputfile<<endl; 
	}
	else
	{
		outputfile << res << " = " << arg1 << "( " << op <<" ) " << arg2;
		outputfile<<endl;
	}
}

quads::quads(string res,string arg1,string arg2,opcode op)
{
	this->res=res;
	this->arg2=arg2;
	this->arg1=arg1;
	this->op=op;
}
void quads::print_quad()
{
	if(ADD<=op && op<=BW_XOR)
	{
		cout<<res<< " = " <<arg1;
		cout<<" ";
		switch(op)
		{
			case ADD: cout<<"+";					  
					  cout<<"";break; 
            case GTE: cout<<">="; 
					  cout<<"";break;
            case LOG_AND: cout<<"&&"; 
					  cout<<"";break;
			case NEQ: cout<<"!="; 
					  cout<<"";break;
            case SR: cout<<">>";   
					  cout<<"";break;
            case LT: cout<<"<"; 
					  cout<<"";break;
            case LOG_OR: cout<<"||"; 
					  cout<<"";break;
            case BW_XOR: cout<<"^"; 
					  cout<<"";break;
			case SUB: cout<<"-";
					  cout<<"";break;
            case LTE: cout<<"<="; 
					  cout<<"";break;
            case BW_OR: cout<<"|"; 
					  cout<<"";break;
            case DIV: cout<<"/"; 
					  cout<<"";break;
			case BW_AND: cout<<"&"; 
					  cout<<"";break;
            case MOD: cout<<"%"; 
					  cout<<"";break;
            case SL: cout<<"<<"; 
					  cout<<"";break;
			case MULT: cout<<"*"; 
					  cout<<"";break;
			case EQ: cout<<"=="; 
					  cout<<"";break;
            case GT: cout<<">"; 
					  cout<<"";break;    
		}
		cout<<" "<<arg2<<endl;
	}
	else if(BW_U_NOT <= op && op<=ASSIGN)
	{
		cout<<res<< " = ";
		switch(op)
		{
			case U_MINUS : cout<<"-";cout<<"";
			break; 
            case U_PLUS : cout<<"+";cout<<"";
			break;
            case BW_U_NOT : cout<<"~";cout<<""; 
			break;
            case U_NEG : cout<<"!";cout<<"";
			break;
            case ASSIGN : cout<<"";cout<<"";
			break;
			case REFERENCE : cout <<"&";cout<<"";
			break;
			case DEREFERENCE : cout <<"*";cout<<"";
		}
		cout << arg1 << endl;
	}
	else if(op==GOTO)
	{
		cout << "goto " << res << endl;
	}
	else if(GOTO_EQ<=op && op<=IF_FALSE_GOTO)
	{
		cout << "if "<< arg1;
		cout<<" ";
		switch(op)
		{
			case   GOTO_GT : cout<<"> ";cout<<"";
            break;
            case   GOTO_LTE : cout<<"<= ";cout<<"";
            break;
            case   IF_FALSE_GOTO : cout<<"== 0";cout<<"";
            break;
            case   GOTO_GTE : cout<<">= ";cout<<"";
            break;
            case   GOTO_EQ : cout<<"== ";cout<<"";
            break;
            case   GOTO_LT : cout<<"< ";cout<<"";
			break;
            case   IF_GOTO : cout<<"!= 0";cout<<""; 
            break;
            case   GOTO_NEQ : cout<<"!= ";cout<<""; 
            break;
            
		}
		cout<<arg2<< "goto "<<res;
		cout<<endl; 
	}
	else if(CtoI<=op && op<=CtoD)
	{
		cout<<res<<" = ";
        switch(op)
        {
            case CtoI : cout<<" ChartoInt("<<arg1;
            			cout<<")"<<endl;
            			break;
            case DtoC : cout<<" DoubletoChar("<<arg1;
            			cout<<")"<<endl; 
            			break;
            case ItoD : cout<<" InttoDouble("<<arg1; 
            			cout<<")"<<endl;
            			break;
            case ItoC : cout<<" InttoChar("<<arg1;
            			cout<<")"<<endl; 
            			break;
            case CtoD : cout<<" ChartoDouble("<<arg1; 
            			cout<<")"<<endl;
            			break;
            case DtoI : cout<<" DoubletoInt("<<arg1; 
            			cout<<")"<<endl;
            			break;
        }  
	}
	else if(op == PARAM)
	{
		cout << "param " << res << endl;
		cout<<endl;
	}
	else if(op == L_DEREF)
    {
    	cout << "*" << res << " = " << arg1;
    	cout<<endl;
    }
	else if(op==CALL)
	{
		if(arg2.size()>0)
			cout << arg2 << " = ";
		cout << "call " << res << " " << arg1;
		cout<<endl;
	}
	else if(op == FUNC_BEG)
    {
        //cout<<"func "<<res<<" starts"<<endl;
        cout << res << ": ";
        cout<<endl;
    }
    else if(op==RETURN)
	{
		cout << "return " << res;
		cout<<endl;
	}
   	else if(op == FUNC_END)
   	{
   		cout << "function " << res << " ends";
   		cout<<endl;
   	}
   	else if(op == DEREFERENCE)
    {
        cout<<res<<" = *"<<arg1;
        cout<<endl;
    }
	else if(op==ARR_IDX_ARG)
	{
		cout << res << " = " << arg1 << "[" << arg2 << "]";
		cout<<endl;
	}
	else if(op == REFERENCE)
    {
    	//cout << "referenceh\n";
        cout<<res<<" = &"<<arg1;
        cout<<endl;
    }
	else if(op==ARR_IDX_RES)
	{
		cout << res << "[" << arg2 << "] = " << arg1;
		cout<<endl; 
	}
	else
	{
		cout << res << " = " << arg1 << "( " << op <<" ) " << arg2;
		cout<<endl;
	}
}
void quad_array::emit(string res, string arg1, string arg2, opcode op)
{
	int weight = 0;
    quads insert(res,arg1,arg2,op);
    weight++;
    list_of_quads.pb(insert);
    next_inst+=weight;
}

void quad_array::emit(string res, char constant, opcode U_op)
{
	int weight = 0;
    stringstream conv;
    string e=""; 
    conv << constant;
    weight++;
    quads insert(res,conv.str(),e,U_op);
    list_of_quads.pb(insert); 
    next_inst+=weight;   
}


void quad_array::emit(string res, double constant, opcode U_op)
{
	int weight = 0;
    stringstream conv; 
    string e=""; 
    conv << constant;
    weight++;
    quads insert(res,conv.str(),e,U_op);
    list_of_quads.pb(insert); 
    next_inst+=weight;
}

void quad_array::emit(string res, int constant, opcode U_op)
{
	int weight = 0;
	stringstream conv; 
	string e=""; 
    conv << constant;
    weight++;
    quads insert(res,conv.str(),e,U_op);
    list_of_quads.pb(insert); 
    next_inst+=weight;
}

void quad_array::backpatch(list<int> dang, int idx)
{
	for (auto it = dang.begin(); it!=dang.end();it++)
	{
		stringstream conv;
		conv << idx;
		conv >> list_of_quads[*it].res;
	}
}

void quad_array::convInttoBool(expression* res)
{
	string e="";
    if(res->type == BOOL) 
        return;
    res->type = BOOL;
    res->FL = makelist(next_inst);
    emit(e,res->loc,e,IF_FALSE_GOTO);
    res->TL = makelist(next_inst);
    emit(e,e,e,GOTO);
    return;
}
void quad_array::convtotype(expression *t, expression *res, Types to_conv)
{
	if(res->type == to_conv)
		return;
	string e="";
	if(res->type == DOUBLE)
	{
		if(to_conv == CHAR)
			emit(t->loc,res->loc,e,DtoC);
		else
			emit(t->loc,res->loc,e,DtoI);
	}
	else if(res->type == INT)
	{
		if(to_conv == CHAR)
			emit(t->loc,res->loc,e,ItoC);
		else
			emit(t->loc,res->loc,e,ItoD);
	}
	else 
	{
		if(to_conv == INT)
			emit(t->loc,res->loc,e,CtoI);
		else
			emit(t->loc,res->loc,e,CtoD);
	}
}
void quad_array::convtotype(string t,Types to, string f, Types from)
{
    if(to == from)
    	return;
    string e="";
    if(from == DOUBLE)
    {
    	if(to == CHAR)
    		emit(t,f,e,DtoC);
    	else
    		emit(t,f,e,DtoI);
    }
    else if(from == CHAR)
    {
    	if(to == INT)
    		emit(t,f,e,CtoI);
    	else
    		emit(t,f,e,CtoD);
    }
    else
    {
    	if(to == CHAR)
    		emit(t,f,e,ItoC);
    	else
    		emit(t,f,e,ItoD);
    }
}

void quads::print_quad_mydebug1(ofstream &outputfile)
{
	if(ADD<=op && op<=BW_XOR)
	{
		outputfile<<res<< " = " <<arg1;
		outputfile<<" ";
		if(op == ADD){
			outputfile<<"+";	
			outputfile<<"the operator for testing is add"; 
		}
		else if(op == GTE){
			outputfile<<">="; 
			outputfile<<"the operator for testing is greater than equal to";
		}
		else if(op == LOG_AND){
			outputfile<<"&&";
			outputfile<<"the operator for testing is logical and";
		}
		else if(op == NEQ){
			outputfile<<"!="; 
			outputfile<<"the operator for testing is not equal to";
		}
		else if(op == SR){
			outputfile<<">>";
			outputfile<<"the operator for testing is shift right";
		}
		else if(op == LT){
			outputfile<<"<";
			outputfile<<"the operator for testing is less than";
		}
		else if(op == LOG_OR){
			outputfile<<"||";
			outputfile<<"the operator for testing is logical or";
		}
		else if(op == BW_XOR){
			outputfile<<"^";
			outputfile<<"the operator for testing is bitwise xor";
		}
		else if(op == SUB){
			outputfile<<"-";
			outputfile<<"the operator for testing is subtract";
		}
		else if(op == LTE){
			outputfile<<"<=";
			outputfile<<"the operator for testing is less than equal to";
		}
		else if(op == BW_OR){
			outputfile<<"|";
			outputfile<<"the operator for testing is bitwise or";
		}
		else if(op == DIV){
			outputfile<<"/";
			outputfile<<"the operator for testing is division";
		}
		else if(op == BW_AND){
			outputfile<<"&";
			outputfile<<"the operator for testing is bitwise and";
		}
		else if(op == MOD){
			outputfile<<"%";
			outputfile<<"the operator for testing is modulo"; 
		}
		else if(op == SL){
			outputfile<<"<<";
			outputfile<<"the operator for testing is shift less";
		}
		else if(op == MULT){
			outputfile<<"*";
			outputfile<<"the operator for testing is multiplication";
		}
		else if(op == EQ){
			outputfile<<"==";
			outputfile<<"the operator for testing is equal to";
		}
		else if(op == GT){
			outputfile<<">";
			outputfile<<"the operator for testing is greater than"; 
		}
		outputfile<<" "<<arg2<<endl;
	}
	else if(BW_U_NOT <= op && op<=ASSIGN)
	{
		outputfile<<res<< " = ";
		if(op == U_MINUS){
			outputfile<<"-";
			outputfile<<"the unary operator is unary minus";
		}
		else if(op == U_PLUS){
			outputfile<<"+";
			outputfile<<"the unary operator is unary plus";
		}
		else if(op == BW_U_NOT){
			outputfile<<"~";
			outputfile<<"the unary operator is bitwise unary not";
		}
		else if(op == U_NEG){
			outputfile<<"!";
			outputfile<<"the unary operator is unary negation";
		}
		else if(op == ASSIGN){
			outputfile<<"";
			outputfile<<"the unary operator is assign operation";
		}
		else if(op == REFERENCE){
			outputfile <<"&";
			outputfile<<"the unary operator is ampersand";
		}
		else if(op == DEREFERENCE){
			outputfile <<"*";
			outputfile<<"the unary operator is pointer";
		}
		outputfile << arg1 << endl;
	}
	else if(op==GOTO)
	{
		outputfile << "goto " << res << endl;
	}
	else if(GOTO_EQ<=op && op<=IF_FALSE_GOTO)
	{
		outputfile << "if "<< arg1;
		outputfile<<" ";
		if(op == GOTO_GT){
			outputfile<<"> greater than";
		}
		else if(op == IF_FALSE_GOTO){
			outputfile<<"== 0 equal to zero";
		}
		else if(op == GOTO_GTE){
			outputfile<<">= greater than equal to";
		}
		else if(op == GOTO_EQ){
			outputfile<<"== equal to";
		}
		else if(op == GOTO_LT){
			outputfile<<"< less than";
		}
		else if(op == IF_GOTO){
			outputfile<<"!= 0 not equal to zero";
		}
		else if(op == GOTO_LTE){
			outputfile<<"<= less than equal";
		}
		else if(op == GOTO_NEQ){
			outputfile<<"!= not equal to";
		}
		outputfile<<arg2<< "goto "<<res;
		outputfile<<endl; 
	}
	else if(CtoI<=op && op<=CtoD)
	{
		outputfile<<res<<" = ";
		if(op == CtoI){
			outputfile<<" ChartoInt( character to integer "<<arg1;
            outputfile<<")"<<endl;
		}
		else if(op == DtoC){
			outputfile<<" DoubletoChar( double to character "<<arg1;
            outputfile<<")"<<endl; 
		}
		else if(op == ItoD){
			outputfile<<" InttoDouble( integer to double "<<arg1; 
            outputfile<<")"<<endl;
		}
		else if(op == ItoC){
			outputfile<<" InttoChar( integer to character "<<arg1;
            outputfile<<")"<<endl;
		}
		else if(op == CtoD){
			outputfile<<" ChartoDouble(character to double "<<arg1; 
            outputfile<<")"<<endl;
		}
		else if(op == DtoI){
			outputfile<<" DoubletoInt( double to integer "<<arg1; 
            outputfile<<")"<<endl;
		}
	}
	else if(op == PARAM)
	{
		outputfile << "parameter" << res << endl;
		outputfile<<endl;
	}
	else if(op == L_DEREF)
    {
    	outputfile << "* derefference operator " << res << " = " << arg1;
    	outputfile<<endl;
    }
	else if(op==CALL)
	{
		if(arg2.size()>0)
			outputfile << arg2 << " = ";
		outputfile << "call " << res << " " << arg1;
		outputfile<<endl;
	}
	else if(op == FUNC_BEG)
    {
        outputfile << res << ": ";
        outputfile<<endl;
    }
    else if(op==RETURN)
	{
		outputfile << "return statement" << res;
		outputfile<<endl;
	}
   	else if(op == FUNC_END)
   	{
   		outputfile << "function end" << res << " ends";
   		outputfile<<endl;
   	}
   	else if(op == DEREFERENCE)
    {
        outputfile<<res<<" = * equal to pointer "<<arg1;
        outputfile<<endl;
    }
	else if(op==ARR_IDX_ARG)
	{
		outputfile << res << " = " << arg1 << "[" << arg2 << "]";
		outputfile<<endl;
	}
	else if(op == REFERENCE)
    {
        outputfile<<res<<" = & equal to ampersand "<<arg1;
        outputfile<<endl;
    }
	else if(op==ARR_IDX_RES)
	{
		outputfile << res << "[" << arg2 << "] = " << arg1;
		outputfile<<endl; 
	}
	else
	{
		outputfile << res << " = " << arg1 << "( " << op <<" ) " << arg2;
		outputfile<<endl;
	}
}

sym_tab_row* sym_tab::lookup(string var,Types t,int count1)
{
	int total=0;
	if(symbol_table.count(var)==0)
	{
		sym_tab_row *insert=new sym_tab_row;
		insert->name=var;
		insert->type.type=t;
		insert->offset=offset;
		insert->init_val=NULL;
		//printf("variable made\n");
		if(count1 == 0)
		{
			if(t == DOUBLE)
			{
				insert->size = size_of_double;
				offset = offset + insert->size;
				total+=offset;
			}
			else if(t == INT)
			{
				insert->size= size_of_int;
				offset = offset + insert->size;
				total+=offset;
			}
			else if(t == PTR)
			{
				//cerr << "var is " << var << "\n";
				insert->size = size_of_pointer;
				offset = offset + insert->size;
				total+=offset;
			}
			else if(t == CHAR)
			{
				insert->size = size_of_char;
				offset = offset + insert->size;
				total+=offset;
			}
			else
			{
				insert->size=0;
				total+=offset;
			}	
		}
		else
		{
			insert->size=size_of_pointer;
			insert->type.type2=t;
			insert->type.pointers=count1;
			insert->type.type=ARRAY;
		}
		symbols.pb(insert);
		symbol_table[var]=insert;
	}
	return symbol_table[var];
}

string sym_tab::gentemp(Types t)
{
	static int total_temps=0;
	string temp_name;
	stringstream temp_name_temp;
	temp_name_temp << "t" << total_temps;
	total_temps++;
	temp_name_temp >> temp_name;
	sym_tab_row *insert=new sym_tab_row;
	// printf("temporary generated \n");
	if(t == DOUBLE)
		insert->size = size_of_double;
	else if(t== PTR)
		insert->size = size_of_pointer;
	else if(t == INT)
		insert->size= size_of_int;
	else if(t == CHAR)
		insert->size = size_of_char;
	else
		insert->size = 0;
	insert->offset=offset;
	insert->type.type=t;
	insert->init_val=NULL;
	insert->name=temp_name;
	//cout << temp_name << "  " << insert->offset <<  endl;
	offset = offset + insert->size;
	symbols.pb(insert);
	symbol_table[temp_name] = insert;
	//cout << "after offset " << offset << endl << endl;
	return temp_name;
}

sym_tab_row* sym_tab::lookup_mydebug(string var,Types t,int count1)
{
	int total=0;
	if(symbol_table.count(var)==0)
	{
		sym_tab_row *insert=new sym_tab_row;
		insert->name=var;
		insert->type.type=t;
		insert->offset=offset;
		insert->init_val=NULL;
		if(count1 == 0)
		{
			switch(t)
			{
				case DOUBLE: insert->size = size_of_double;
							offset = offset + insert->size;
							total+=offset;
							cout<<"In double in lookup table";
							break;
				case INT: insert->size= size_of_int;
						offset = offset + insert->size;
						total+=offset;
						cout<<"In integer in lookup table";
						break;
				case PTR: insert->size = size_of_pointer;
						offset = offset + insert->size;
						total+=offset;
						cout<<"In pointer in lookup table";
						break;
				case CHAR: insert->size = size_of_char;
						offset = offset + insert->size;
						total+=offset;
						cout<<"In character in lookup table";
						break;
				default: insert->size=0;
						total+=offset;
						cout<<"In deafult case in lookup table";

			}
		}
		else
		{
			insert->size=size_of_pointer;
			insert->type.type2=t;
			insert->type.pointers=count1;
			insert->type.type=ARRAY;
		}
		symbols.pb(insert);
		symbol_table[var]=insert;
	}
	return symbol_table[var];
}

void sym_tab::print_symtab(ofstream &outputfile)
{
	// ofstream cout (inputfile);
	outputfile<<"Name\t\tType\t\tInit_Val\t\tSize\t\tOffset\n";
	sym_tab_row *curr;
	string empty="";
	for(int i=0;i<symbols.size();i++)
	{
		curr=symbols[i];
		outputfile << curr->name << "\t\t";
		if(curr->type.type==DOUBLE)
		{
			outputfile << "double";outputfile<<empty;
		}
		else if(curr->type.type==FUNCTION)
		{
			outputfile << "function";outputfile<<empty;
		}
		else if(curr->type.type==INT)
		{
			outputfile << "int";outputfile<<empty; 
		}
		else if(curr->type.type==CHAR)
		{
			outputfile << "char";outputfile<<empty;
		}
		else if(curr->type.type == ARRAY)
		{
			outputfile<<empty;
			if(curr->type.type2 == INT)
				outputfile << "int"; 
			else if(curr->type.type2 == CHAR)
				outputfile << "char";
			else if(curr->type.type2 == DOUBLE)
				outputfile << "double";
			outputfile<<empty;
			vector<int> dim = curr->type.dims;
			for(int i=0;i<dim.size();i++)
			{
				if(dim[i]!=0)
					outputfile<<"["<<dim[i]<<"]";
				else
					outputfile<<"[]";
			}
			if(dim.size()!=0);
			else outputfile<<"[]";
		}
		else if(curr->type.type==PTR)
		{
			if(curr->type.type2==DOUBLE)
				outputfile << "double";
			outputfile<<empty;
			if(curr->type.type2==INT)
				outputfile << "int"; 
			if(curr->type.type2==CHAR)
				outputfile << "char";
			for(int i=0;i<curr->type.pointers;i++)
				outputfile << "*";
			outputfile<<empty;
		}
		
		outputfile << "\t\t" ;
		if(curr->init_val!=NULL)
		{
			if(curr->type.type==CHAR)
				outputfile << curr->init_val->b;
			if(curr->type.type==INT)
				outputfile << curr->init_val->a;
			else if(curr->type.type==DOUBLE)
				outputfile << curr->init_val->c;
			else
				outputfile << "--";
		}
		else
		{
			outputfile << "null";			
		}
		outputfile << "\t\t";
		outputfile << curr->size;
		outputfile << "\t\t";
		outputfile << curr->offset;
		outputfile << endl;
	}
}

void quads::print_quad_mydebug2()
{
	if(ADD<=op && op<=BW_XOR)
	{
		cout<<res<< " = " <<arg1;
		cout<<" ";
		if(op == ADD){
			cout<<"+";	
			cout<<"the operator for testing is and"; 
		}
		else if(op == GTE){
			cout<<">="; 
			cout<<"the operator for testing is greater than equal to";
		}
		else if(op == LOG_AND){
			cout<<"&&";
			cout<<"the operator for testing is logical and";
		}
		else if(op == NEQ){
			cout<<"!="; 
			cout<<"the operator for testing is not equal to";
		}
		else if(op == SR){
			cout<<">>";
			cout<<"the operator for testing is shift right";
		}
		else if(op == LT){
			cout<<"<";
			cout<<"the operator for testing is less than";
		}
		else if(op == LOG_OR){
			cout<<"||";
			cout<<"the operator for testing is logical or";
		}
		else if(op == BW_XOR){
			cout<<"^";
			cout<<"the operator for testing is bitwise xor";
		}
		else if(op == SUB){
			cout<<"-";
			cout<<"the operator for testing is subtract";
		}
		else if(op == LTE){
			cout<<"<=";
			cout<<"the operator for testing is less than equal";
		}
		else if(op == BW_OR){
			cout<<"|";
			cout<<"the operator for testing is bitwise or";
		}
		else if(op == DIV){
			cout<<"/";
			cout<<"the operator for testing is division";
		}
		else if(op == BW_AND){
			cout<<"&";
			cout<<"the operator for testing is bitwise and";
		}
		else if(op == MOD){
			cout<<"%";
			cout<<"the operator for testing is modulo"; 
		}
		else if(op == SL){
			cout<<"<<";
			cout<<"the operator for testing is shift left";
		}
		else if(op == MULT){
			cout<<"*";
			cout<<"the operator for testing is multiplication";
		}
		else if(op == EQ){
			cout<<"==";
			cout<<"the operator for testing is equal";
		}
		else if(op == GT){
			cout<<">";
			cout<<"the operator for testing is greater than"; 
		}
		cout<<" "<<arg2<<endl;
	}
	else if(BW_U_NOT <= op && op<=ASSIGN)
	{
		cout<<res<< " = ";
		if(op == U_MINUS){
			cout<<"-";
			cout<<"unary minus";
		}
		else if(op == U_PLUS){
			cout<<"+";
			cout<<"unary plus";
		}
		else if(op == BW_U_NOT){
			cout<<"~";
			cout<<"bitwise unary not";
		}
		else if(op == U_NEG){
			cout<<"!";
			cout<<"unary negation";
		}
		else if(op == ASSIGN){
			cout<<"";
			cout<<"assign";
		}
		else if(op == REFERENCE){
			cout <<"&";
			cout<<"ampersand";
		}
		else if(op == DEREFERENCE){
			cout <<"*";
			cout<<"pointer";
		}
		cout << arg1 << endl;
	}
	else if(op==GOTO)
	{
		cout << "goto " << res << endl;
	}
	else if(GOTO_EQ<=op && op<=IF_FALSE_GOTO)
	{
		cout << "if "<< arg1;
		cout<<" ";
		if(op == GOTO_GT){
			cout<<"> greater than";
		}
		else if(op == IF_FALSE_GOTO){
			cout<<"== 0 equal to zero";
		}
		else if(op == GOTO_GTE){
			cout<<">= greater than equal to";
		}
		else if(op == GOTO_EQ){
			cout<<"== equal to";
		}
		else if(op == GOTO_LT){
			cout<<"< less than";
		}
		else if(op == IF_GOTO){
			cout<<"!= 0 not equal to";
		}
		else if(op == GOTO_LTE){
			cout<<"<= less than equal to";
		}
		else if(op == GOTO_NEQ){
			cout<<"!= not equal to";
		}
		cout<<arg2<< "goto "<<res;
		cout<<endl; 
	}
	else if(CtoI<=op && op<=CtoD)
	{
		cout<<res<<" = ";
		if(op == CtoI){
			cout<<" ChartoInt( character to integer "<<arg1;
            cout<<")"<<endl;
		}
		else if(op == DtoC){
			cout<<" DoubletoChar( double to character "<<arg1;
            cout<<")"<<endl; 
		}
		else if(op == ItoD){
			cout<<" InttoDouble( integer to double "<<arg1; 
            cout<<")"<<endl;
		}
		else if(op == ItoC){
			cout<<" InttoChar( integer to character "<<arg1;
            cout<<")"<<endl;
		}
		else if(op == CtoD){
			cout<<" ChartoDouble( character to double "<<arg1; 
            cout<<")"<<endl;
		}
		else if(op == DtoI){
			cout<<" DoubletoInt( double to integer "<<arg1; 
            cout<<")"<<endl;
		}
	}
	else if(op == PARAM)
	{
		cout << "parameter " << res << endl;
		cout<<endl;
	}
	else if(op == L_DEREF)
    {
    	cout << "* pointer " << res << " = " << arg1;
    	cout<<endl;
    }
	else if(op==CALL)
	{
		if(arg2.size()>0)
			cout << arg2 << " = ";
		cout << "call " << res << " " << arg1;
		cout<<endl;
	}
	else if(op == FUNC_BEG)
    {
        cout << res << ": ";
        cout<<endl;
    }
    else if(op==RETURN)
	{
		cout << "return statement " << res;
		cout<<endl;
	}
   	else if(op == FUNC_END)
   	{
   		cout << "function end" << res << " ends";
   		cout<<endl;
   	}
   	else if(op == DEREFERENCE)
    {
        cout<<res<<" = * equal to pointer "<<arg1;
        cout<<endl;
    }
	else if(op==ARR_IDX_ARG)
	{
		cout << res << " = " << arg1 << "[" << arg2 << "]";
		cout<<endl;
	}
	else if(op == REFERENCE)
    {
        cout<<res<<" = &"<<arg1;
        cout<<endl;
    }
	else if(op==ARR_IDX_RES)
	{
		cout << res << "[" << arg2 << "] = " << arg1;
		cout<<endl; 
	}
	else
	{
		cout << res << " = " << arg1 << "( " << op <<" ) " << arg2;
		cout<<endl;
	}
}


list<int> makelist(int index)
{
    list<int> new_list;
    new_list.pb(index);
    list<int> label;
    return new_list;
}
list<int> merge(list<int> a, list<int> b)
{
    list<int> merged;
    merged.merge(a);
    list<int> label;
    merged.merge(b);
    return merged;
}

