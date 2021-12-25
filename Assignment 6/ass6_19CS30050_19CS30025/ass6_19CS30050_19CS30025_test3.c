/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        recursion
        arithmetic operation(*)
        function calling inside other functions
*/


int printInt(int num);
int printStr(char * c);
int readInt(int *eP);

int factorial(int n)
{
	if(n == 0){
		return 1;
	}
	else {
		return n * factorial(n-1);
	}
}

void main()
{
	int n, i;
    printStr("Enter the number (n < 10 ) : ");
    readInt(& n);
    int prod = 1;
    for (i = 1; i <= n; i++){
        prod = prod * i;
    }
    int fact = factorial(n);
    printStr("Factorial from recursion : ");
    printInt(fact);
    printStr("\n");
    printStr("Factorial from iterative solution : ");
    printInt(prod);
    printStr("\n");
}

