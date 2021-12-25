
/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    Target Translator File
*/


#include "ass6_19CS30050_19CS30025_translator.h"

//varaibles used
string func_running="";
void GENCODE();

extern quad_array QUAD_LIST;
void STRINGS();
extern sym_tab gst;
void GLOBAL();
extern sym_tab *GST;
void quad_codes(quads q);
extern vector<string> str_consts;
map<int,string> labels;

void GLOBAL()
{
	std::vector<sym_tab_row*>::iterator it;
	for (it = gst.symbols.begin(); it != gst.symbols.end(); ++it)
	{
		
		if((*it)->type.type==CHAR && (*it)->name[0]!='t')
		{
			if((*it)->init_val!=NULL)
			{
				cout << "\t.globl\t" << (*it)->name << endl;
				cout << "\t.data"<<endl;
				int tempp=(*it)->init_val->b;
				cout << "\t.type\t" << (*it)->name;
				cout << ", @object" << endl<< "\t.size\t" ;
				cout << (*it)->name << ", 1" << endl<<(*it)->name;
				cout <<":"<<endl<< "\t.byte\t" << tempp << endl;
			}
			else
			{
				cout << "\t.comm\t" << (*it)->name;
				cout << ",1,1" << endl;	
			}
		}
		if((*it)->type.type==INT && (*it)->name[0]!='t')
		{
			if((*it)->init_val!=NULL)
			{
				cout << "\t.globl\t" << (*it)->name << endl<< "\t.data"<<endl;
				cout << "\t.align\t4"<<endl;
				cout << "\t.type\t" << (*it)->name;
				cout << ", @object" << endl;
				cout << "\t.size\t" << (*it)->name;
				cout << ", 4" << endl;
				cout << (*it)->name <<":"<<endl<< "\t.long\t" << (*it)->init_val->a << endl;
			}
			else
			{
				cout << "\t.comm\t" << (*it)->name << ",4,4";
				cout<<endl;	
			}

		}
	}
}
int label_count=0;
stack<pair<string,int> > parameters;
void STRINGS()
{
	cout<<".section\t.rodata\n";
	int num=0;
	std::vector<string>::iterator it;
	for (it = str_consts.begin(); it != str_consts.end(); ++it)
	{
		cout << ".LC" << num++ << ":"<<endl;

		cout << "\t.string " <<  *it << endl;
	}
	
}

void set_labels()
{
	std::vector<quads>::iterator it;
	int counter=0;
	for (it = QUAD_LIST.list_of_quads.begin(); it != QUAD_LIST.list_of_quads.end(); )
	{
		if(it->op == GOTO || (it->op>=GOTO_EQ && it->op<=IF_FALSE_GOTO) )
		{
			stringstream targ;
			targ << it->res;
			int target;
			targ >> target;
			if(!labels.count(target))
			{
				stringstream name;
				counter++;
				name << ".L" << label_count;
				string label_name;
				name >> label_name;
				label_count++;
				labels[target]=label_name; 
			}
			it->res=labels[target];
		}
		it++;
	}
}

void gen_prologue(int mem_bind)
{
	int width =16;
	cout << "\t.text"<<endl<< "\t.globl\t";
	cout << func_running << endl<< "\t.type\t";
	cout << func_running << ", @function"<<endl;
	cout << func_running << ":"<<endl;
	int space=(mem_bind/width + 1);
	//cout << "\t.cfi_startproc\n";
	cout << "\tpushq\t%rbp"<<endl;
	//ut << "\t.cfi_def_cfa_offset 16\n";
	//cout << "\t.cfi_offset 6, -16\n";
	cout << "\tmovq\t%rsp, %rbp"<<endl;
	space*=width;
	//cout << "\t.cfi_def_cfa_register 6\n";
	cout << "\tsubq\t$" << space << ", %rsp"<<endl;
}
sym_tab_row* sym_tab::look_in_global(string var)
{
	if(symbol_table.count(var))
		return symbol_table[var];
	else
		return NULL;
}

void gencode(ofstream &outputfile)
{
	GLOBAL();
	STRINGS();
	sym_tab *curr_func_tab=NULL;
	int i;
	int counter=0;
	sym_tab_row *curr_func=NULL;
	string empty="";
	counter++;
	set_labels();
	//cout << "\t.text";cout<<endl;
	for(i=0;i<QUAD_LIST.list_of_quads.size();i++)
	{
		cout << "# " ;
		QUAD_LIST.list_of_quads[i].print_quad();
		counter++;
		if(labels.count(i))
		{
			cout << labels[i] << ":";cout<<endl;
			counter++;
		}
		if(QUAD_LIST.list_of_quads[i].op==FUNC_BEG)
		{
			i++;
			if(QUAD_LIST.list_of_quads[i].op!=FUNC_END)
			{	
				i--;
				counter++;
			}
			else
				continue;
			counter++;
			curr_func=gst.look_in_global(QUAD_LIST.list_of_quads[i].res);
			curr_func_tab=curr_func->nested_table;
			//ret val and return address at 0  and 4
			int taking_param=1,mem_bind=16;
			GST=curr_func_tab;
			for(int j=0;j<curr_func_tab->symbols.size();j++)
			{
				if(curr_func_tab->symbols[j]->name == "RETVAL")
				{
					taking_param=0;
					mem_bind=0;
					counter++;
					if(curr_func_tab->symbols.size()>j+1)
						mem_bind=-curr_func_tab->symbols[j+1]->size;
				}
				else
				{
					if(!taking_param)
					{
						curr_func_tab->symbols[j]->offset=mem_bind;
						counter++;
						if(curr_func_tab->symbols.size()>j+1)
							mem_bind-=curr_func_tab->symbols[j+1]->size;
					}
					else
					{
						curr_func_tab->symbols[j]->offset=mem_bind;
						counter++;
						mem_bind+=8;
					}

				}
			}
			if(mem_bind>=0)
				mem_bind=0;
			else
				mem_bind=(-1)*mem_bind;
			func_running=QUAD_LIST.list_of_quads[i].res;
			counter++;
			gen_prologue(mem_bind);
		}
		else if(QUAD_LIST.list_of_quads[i].op==FUNC_END)
		{
			GST=&(gst);
			counter++;
			cout<<"";
			func_running=empty;
			cout << "\tleave"<<endl<< "\tret";cout<<endl;
			counter++;
			cout<<"";
			cout << "\t.size\t" << QUAD_LIST.list_of_quads[i].res;
			cout << ", .-" << QUAD_LIST.list_of_quads[i].res<<endl;
		}

		if(func_running==empty);
		else quad_codes(QUAD_LIST.list_of_quads[i]);

	}
}






void quad_codes(quads q)
{
	string have_label=q.res;
	bool has_str_label=false;
	string empty="";
	if(q.res[1]=='L' &&q.res[0]=='.' &&  q.res[2]=='C')
		has_str_label=true;
	string to_print1=empty;
	int counter=0;
	string to_print2=empty,to_printres=empty;
	sym_tab_row *local2=GST->lookup(q.arg2);
	counter++;
	sym_tab_row *local1=GST->lookup(q.arg1);
	int off1=0,off2=0,offres=0;
	sym_tab_row *local3=GST->lookup(q.res);
	sym_tab_row *global2=gst.look_in_global(q.arg2);
	counter++;
	sym_tab_row *global1=gst.look_in_global(q.arg1);
	sym_tab_row *global3=gst.look_in_global(q.res);
	if(GST!=&gst)
	{
		if(global2!=NULL);
		else off2=local2->offset;
		if(global1!=NULL);
		else off1=local1->offset;
		if(global3!=NULL);
		else offres=local3->offset;
		if(q.arg1[0]>'9' || q.arg1[0]<'0')
		{
			if(global1!=NULL)
			{
				to_print1=q.arg1+"(%rip)";
			}
			else
			{
				stringstream conv;
				conv << off1;
				conv >> to_print1;
				to_print1=to_print1+"(%rbp)";
			}
		}
		if(q.res[0]>'9' || q.res[0]<'0')
		{
			if(global3!=NULL)
			{
				to_printres=q.res+"(%rip)";	
				counter++;
			}
			else
			{
				stringstream conv;
				conv << offres;
				conv >> to_printres;
				to_printres=to_printres+"(%rbp)";
				
			}
		}
		if(q.arg2[0]>'9' || q.arg2[0]<'0')
		{
			if(global2!=NULL)
			{
				counter++;
				to_print2=q.arg2+"(%rip)";
			}
			else
			{
				stringstream conv;
				conv << off2;
				conv >> to_print2;
				to_print2=to_print2+"(%rbp)";
			}
		}

	}
	else
	{
		to_print2=q.arg2;
		counter++;
		to_print1=q.arg1;
		counter++;
		to_printres=q.res;
	}

	if(has_str_label)
		to_printres=have_label;

	if(q.op==ASSIGN)
	{
		if(local3->type.type==INT ||q.res[0]!='t' ||  local3->type.type==PTR)
		{
			if(local3->type.type!=PTR)
			{
				if(q.arg1[0]>'9'||q.arg1[0]<'0')
				{
					cout << "\tmovl\t" << to_print1;
					cout << ", %eax" << endl;
					cout << "\tmovl\t%eax, ";
					cout << to_printres << endl; 
				}
				else
				{
					cout << "\tmovl\t$" << q.arg1 << ", ";
					cout << to_printres << endl;
				}
			}
			else
			{
				cout << "\tmovq\t" << to_print1;
				cout << ", %rax" << endl;
				cout << "\tmovq\t%rax, ";
				cout << to_printres << endl; 
			}
		}
		else
		{
			int temp=q.arg1[0];
			cout << "\tmovb\t$" << temp;
			cout << ", " << to_printres << endl;
		}
	}
	else if(q.op==U_MINUS)
	{
		cout << "\tmovl\t" << to_print1;
		cout << ", %eax";cout<<endl;
		cout << "\tnegl\t%eax";cout<<endl;
		cout << "\tmovl\t%eax, " << to_printres ;cout<<endl; 
	}
	else if(q.op==ADD)
	{
		if(!(q.arg1[0]>'0' && q.arg1[0]<='9'))
		{
			cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl; 
		}
		else
		{
			cout << "\tmovl\t$" << q.arg1 << ", %eax";cout<<endl;
		}
		if(q.arg2[0]>'0' && q.arg2[0]<='9')
		{
			cout << "\tmovl\t$" << q.arg2 << ", %edx";cout<<endl;
		}
		else
		{
			cout << "\tmovl\t" << to_print2 << ", %edx";cout<<endl; 
		}
		cout << "\taddl\t%edx, %eax";cout<<endl;
		cout << "\tmovl\t%eax, " << to_printres ;cout<<endl;

	}
	else if(q.op==SUB)
	{
		if(!(q.arg1[0]>'0' && q.arg1[0]<='9'))
		{
			cout << "\tmovl\t" << to_print1 << ", %edx";cout<<endl; 	
		}
		else
		{
			cout << "\tmovl\t$" << q.arg1 << ", %edx";cout<<endl;
		}
		if(q.arg2[0]>'0' && q.arg2[0]<='9')
		{
			cout << "\tmovl\t$" << q.arg2 << ", %eax";cout<<endl;
		}
		else
		{
			cout << "\tmovl\t" << to_print2 << ", %eax";cout<<endl; 
		}
		cout << "\tsubl\t%eax, %edx";cout<<endl;
		cout << "\tmovl\t%edx, %eax";cout<<endl;
		cout << "\tmovl\t%eax, " << to_printres ;cout<<endl;
	}
	else if(q.op==MULT)
	{
		if(!(q.arg1[0]>'0' && q.arg1[0]<='9'))
		{
			cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl; 
		}
		else
		{
			cout << "\tmovl\t$" << q.arg1 << ", %eax";cout<<endl;
		}
		cout << "\timull\t";
		if(q.arg2[0]>'0' && q.arg2[0]<='9')
		{
			cout << "$" << q.arg2 << ", %eax";cout<<endl;
		}
		else
		{
			cout << to_print2 << ", %eax";cout<<endl;
		}
		cout << "\tmovl\t%eax, " << to_printres ;cout<<endl;
	}
	else if(q.op==MOD)
	{
		cout << "\tmovl\t" << to_print1;
		cout << ", %eax"<<endl;
		cout << "\tcltd\n\tidivl\t" << to_print2 ;cout<<endl;
		cout << "\tmovl\t%edx, " << to_printres ;cout<<endl;
	}
	else if(q.op==DIV)
	{
		cout << "\tmovl\t" << to_print1;
		cout << ", %eax"<<endl;
		cout << "\tcltd\n\tidivl\t" << to_print2 ;cout<<endl;
		cout << "\tmovl\t%eax, " << to_printres ;cout<<endl;
	}
	
	else if(q.op==GOTO)
	{
		cout << "\tjmp\t" << q.res ;cout<<endl;
	}
	else if(q.op==GOTO_LT)
	{
		cout << "\tmovl\t" << to_print1;
		cout << ", %eax"<<endl;
		cout << "\tcmpl\t" << to_print2 << ", %eax";cout<<endl;
		cout << "\tjge\t.L" << label_count;cout<<endl;
		cout << "\tjmp\t" << q.res ;cout<<endl;
		cout << ".L" << label_count++ << ":";cout<<endl;
	}
	else if(q.op==GOTO_GT)
	{
		cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl;
		cout << "\tcmpl\t" << to_print2 << ", %eax";cout<<endl;
		cout << "\tjle\t.L" << label_count;cout<<endl;
		cout << "\tjmp\t" << q.res ;cout<<endl;
		cout << ".L" << label_count++ << ":";cout<<endl;
	}
	else if(q.op==GOTO_GTE)
	{
		cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl;
		cout << "\tcmpl\t" << to_print2 << ", %eax";cout<<endl;
		cout << "\tjl\t.L" << label_count;cout<<endl;
		cout << "\tjmp\t" << q.res ;cout<<endl;
		cout << ".L" << label_count++ << ":";cout<<endl;
	}
	else if(q.op==GOTO_LTE)
	{
		cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl;
		cout << "\tcmpl\t" << to_print2 << ", %eax";cout<<endl;
		cout << "\tjg\t.L" << label_count;cout<<endl;
		cout << "\tjmp\t" << q.res ;cout<<endl;
		cout << ".L" << label_count++ << ":";cout<<endl;
	}
	else if(q.op==GOTO_GTE)
	{
		cout << "\tmovl\t"<< to_print1 << ", %eax"<<endl;
		cout << "\tcmpl\t" << to_print2 << ", %eax"<<endl<< "\tjl\t.L" << label_count <<endl;
		cout << "\tjmp\t" << q.res << endl;
		cout << ".L" << label_count++ << ":"<<endl;
	}
	else if(q.op==GOTO_EQ)
	{
		cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl;
		if(q.arg2[0]>='0' && q.arg2[0]<='9')
		{
			cout << "\tcmpl\t$" << q.arg2 << ", %eax";cout<<endl;
		}
		else
		{
			cout << "\tcmpl\t" << to_print2 << ", %eax";cout<<endl;
		}
		cout << "\tjne\t.L" << label_count;cout<<endl;
		cout << "\tjmp\t" << q.res ;cout<<endl;
		cout << ".L" << label_count++ << ":";cout<<endl;
	}
	else if(q.op==GOTO_NEQ)
	{
		cout << "\tmovl\t" << to_print1 << ", %eax"<<endl;
		cout << "\tcmpl\t" << to_print2 << ", %eax"<<endl;
		cout << "\tje\t.L" << label_count<<endl;
		cout << "\tjmp\t" << q.res << endl;
		cout << ".L" << label_count++ << ":"<<endl;
	}
	else if(q.op==IF_GOTO)
	{
		cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl;
		cout << "\tcmpl\t$0" << ", %eax";cout<<endl;
		cout << "\tje\t.L" << label_count;cout<<endl;
		cout << "\tjmp\t" << q.res ;cout<<endl;
		cout << ".L" << label_count++ << ":";cout<<endl;
	}
	else if(q.op==IF_FALSE_GOTO)
	{
		cout << "\tmovl\t" << to_print1 << ", %eax"<<endl;
		cout << "\tcmpl\t$0" << ", %eax"<<endl;
		cout << "\tjne\t.L" << label_count <<endl;
		cout << "\tjmp\t" << q.res << endl;
		cout << ".L" << label_count++ << ":"<<endl;
	}
	else if(q.op==ARR_IDX_ARG)
	{
		
		cout<<"\tmovl\t"<<to_print2<<", %edx";cout<<endl;
		cout<<"cltq";cout<<endl;
		if(off1<0)
		{
				cout<<"\tmovl\t"<<off1<<"(%rbp,%rdx,1), %eax";cout<<endl;
				cout<<"\tmovl\t%eax, "<<to_printres;cout<<endl;
		}
		else
		{
			cout<<"\tmovq\t"<<off1<<"(%rbp), %rdi";cout<<endl;
			cout<<"\taddq\t%rdi, %rdx";cout<<endl;
			cout<<"\tmovq\t(%rdx) ,%rax";cout<<endl;
			cout<<"\tmovq\t%rax, "<<to_printres;cout<<endl;
		}
	}
	else if(q.op==ARR_IDX_RES)
	{
		cout<<"\tmovl\t"<<to_print2<<", %edx";cout<<endl;
		cout<<"\tmovl\t"<<to_print1<<", %eax";cout<<endl;
		cout<<"cltq";cout<<endl;
		if(offres>0)
		{
			cout<<"\tmovq\t"<<offres<<"(%rbp), %rdi";cout<<endl;
			cout<<"\taddq\t%rdi, %rdx";cout<<endl;
			cout<<"\tmovl\t%eax, (%rdx)";cout<<endl;
		}
		else
		{
			cout<<"\tmovl\t%eax, "<<offres<<"(%rbp,%rdx,1)";cout<<endl;
		}
	}
	else if(q.op==REFERENCE)
	{
		if(off1<0)
		{
			cout << "\tleaq\t" << to_print1 << ", %rax";cout<<endl;
			cout << "\tmovq\t%rax, " << to_printres ;cout<<endl;
		}
		else
		{
			cout << "\tmovq\t" << to_print1 << ", %rax";cout<<endl;
			cout << "\tmovq\t%rax, " << to_printres ;cout<<endl;
		}
	}
	else if(q.op==DEREFERENCE)
	{
		cout << "\tmovq\t" << to_print1 << ", %rax";cout<<endl;
		cout << "\tmovq\t(%rax), %rdx"<<endl;
		cout << "\tmovq\t%rdx, " << to_printres ;cout<<endl;
	}
	else if(q.op==L_DEREF)
	{
		cout << "\tmovq\t" << to_printres << ", %rdx";cout<<endl;
		cout << "\tmovl\t" << to_print1 << ", %eax";cout<<endl;
		cout << "\tmovl\t%eax, (%rdx)";cout<<endl;
		//cout << "\tmovl\t%eax, " << to_printres;cout<<endl;
	}
	else if(q.op==PARAM)
	{
		int size_of_param;
		Types t;
		if(global3!=NULL)
			t=global3->type.type;
		else
			t=local3->type.type;
		if(t==CHAR)
			size_of_param=size_of_char;
		else if(t==INT)
			size_of_param=size_of_int;
		else
			size_of_param=size_of_pointer;
		stringstream one;
		if(q.res[0]=='.')
		{
			one << "\tmovq\t$" << to_printres << ", %rax"<<endl;
		}
		else if(q.res[0]>='0' && q.res[0]<='9')
		{
			one << "\tmovq\t$" << q.res << ", %rax"<<endl;
		}
		else
		{
			if(local3->type.type!=ARRAY)
			{
				if(local3->type.type!=PTR)
				{
					one << "\tmovq\t" << to_printres << ", %rax"<<endl;
				}
				else if(local3==NULL)
				{
					one << "\tleaq\t" << to_printres << ", %rax"<<endl;
				}
				else
				{
					one << "\tmovq\t" << to_printres << ", %rax"<<endl;
				}
			}
			else
			{
				if(offres<0)
					one << "\tleaq\t" << to_printres << ", %rax"<<endl;
				else
				{
					one<<"\tmovq\t"<<offres<<"(%rbp), %rdi"<<endl;
					one << "\tmovq\t%rdi, %rax"<<endl;
				}
			}
		}
		parameters.push(make_pair(one.str(),size_of_param));
	}
	else if(q.op==CALL)
	{
		int num_of_params;
		stringstream conv;
		conv << q.arg1;
		conv >> num_of_params;
		int total_size=0;
		int k=0;
		int counter=0;
		
		if(num_of_params>6)
		{
			for(int i=0;i<num_of_params-6;i++)
			{
				string s=parameters.top().first;
				cout << s;
				cout << "\tpushq\t%rax";cout<<endl;
				total_size+=parameters.top().second;
				parameters.pop();
			}
			cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
			cout << "\tmovq\t%rax, %r9d";cout<<endl;
			counter+=parameters.top().second;
			parameters.pop();
			cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
			cout << "\tmovq\t%rax, %r8d";cout<<endl;
			counter+=parameters.top().second;				
			parameters.pop();
			cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
			cout << "\tmovq\t%rax, %rcx";cout<<endl;
			counter+=parameters.top().second;
			parameters.pop();
			cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
			cout << "\tmovq\t%rax, %rdx";cout<<endl;
			counter+=parameters.top().second;
			parameters.pop();
			cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
			cout << "\tmovq\t%rax, %rsi";cout<<endl;
			counter+=parameters.top().second;
			parameters.pop();
			cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
			cout << "\tmovq\t%rax, %rdi";cout<<endl;
			counter+=parameters.top().second;
			total_size+=counter;
			parameters.pop();
		}
		else
		{
			while(!parameters.empty())
			{
				if(parameters.size()==1)
				{
					cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
					cout << "\tmovq\t%rax, %rdi";cout<<endl;
					total_size+=parameters.top().second;
					parameters.pop();
				}
				else if(parameters.size()==6)
				{
					cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
					cout << "\tmovq\t%rax, %r9d";cout<<endl;
					total_size+=parameters.top().second;
					parameters.pop();
				}
				else if(parameters.size()==2)
				{
					cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
					cout << "\tmovq\t%rax, %rsi";cout<<endl;
					total_size+=parameters.top().second;
					parameters.pop();
				}
				else if(parameters.size()==5)
				{
					cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
					cout << "\tmovq\t%rax, %r8d";cout<<endl;
					total_size+=parameters.top().second;
					parameters.pop();
				}
				else if(parameters.size()==3)
				{
					cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
					cout << "\tmovq\t%rax, %rdx";cout<<endl;
					total_size+=parameters.top().second;
					parameters.pop();
				}
				
				else if(parameters.size()==4)
				{
					cout << parameters.top().first << "\tpushq\t%rax";cout<<endl;
					cout << "\tmovq\t%rax, %rcx";cout<<endl;
					total_size+=parameters.top().second;
					parameters.pop();
				}
				
				
			}
		}
		cout << "\tcall\t";
		cout << q.res;cout<<endl;
		if(q.arg2!= empty)
			cout << "\tmovq\t%rax, "<< to_print2 ;cout<<endl;
		cout<< "\taddq\t$" << total_size;
		cout<< ", %rsp";cout<<endl;
	}
	else if(q.op==RETURN)
	{
		if(q.res!=empty)
		{
			cout << "\tmovq\t" << to_printres << ", %rax";cout<<endl;
		}
		cout << "\tleave"<<endl<< "\tret";cout<<endl;
	}
}

