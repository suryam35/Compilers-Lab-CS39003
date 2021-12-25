
/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        global variable
        scope management
        different looping statements(do while)
        if else conditionals 
        function calling inside other functions
*/



int printStr(char *c);
int printInt(int i);
int readInt(int *eP);
int e=5;			// scope of global variables

int main()
{
  	// scope management 
    { 
      int w=1;
      printStr("\nvalue of the same variable in Scope1:");printInt(w);
      { 
        int w=2;
        printStr("\nvalue of the same variable inScope2:");printInt(w);
        { 
          int w=3;
          if(w == 1){
            printStr("The program is giving wrong output since it gives value of scope 1 only");
          }
          if(w == 2){
            printStr("The program is giving wrong output since it gives value of scope 2 only");
          }
          printStr("\nvalue of the same variable inScope3:");printInt(w);
        }
      }

    }
    // do while testing
    int do_iterator=0;
    do {
      printStr("\n  This is just for checking \n ");
      printInt(do_iterator);
      
      do_iterator = do_iterator + 10;
    }while(do_iterator<100);
    printStr("\n");
  return 0;
}
