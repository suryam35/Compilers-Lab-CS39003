
/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        1D arrays
        arithmetic operations in array elements
        global variable
        pointers and addresses
*/



int printStr(char *c);
int printInt(int i);
int readInt(int *eP);
int e=5;			// test : scope of global variables

int main()
{

  int a=5;
  // test : poiters
  int *d;
  int *e;
  printStr("The below print statement should print 5");
  printStr("\n");
  d=&a;
  printInt(*d);
  printStr("\n");
  
  e=&a;   // assign same two pointer to a variable
  a--;
  *d=4;
  printStr("The below print statement should print 4");
  printStr("\n");
  printInt(*d);
  printStr("\n");
  printInt(a);
  printStr("\n");
  a--;
  printStr("After decrementing a The below print statement should print 3");
  printStr("\n");
  printInt(*d);
  printStr("\n");
  printInt(*e);
    // Test Expressions
    int test = 1;
    int a=3, b=2;
    // array operations
    int arr[9];
    arr[0]=1;
    arr[1]=2;
    a=1;
    e = 5;
    arr[0]=e;
    arr[1]=(a+b);
    arr[2]=arr[0]*arr[1];
    arr[3]=a*b;
    arr[4]=a++;
    arr[5]=--b;
    arr[6]=0;
    arr[7]=a/b;
    arr[8]=a%b;
    printStr("\narr[0] = ");printInt(arr[0]);
    printStr("\narr[1] = ");printInt(arr[1]);
    printStr("\narr[2] = ");printInt(arr[2]);
    printStr("\narr[3] = ");printInt(arr[3]);
    printStr("\narr[4] = ");printInt(arr[4]);
    printStr("\narr[5] = ");printInt(arr[5]);
    printStr("\narr[6] = ");printInt(arr[6]);
    printStr("\narr[7] = ");printInt(arr[7]);
    printStr("\narr[8] = ");printInt(arr[8]);
    printStr("\n");

  return 0;
}
