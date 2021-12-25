/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
	This test files covers things as:
		arithmetic operation(+)
		function calling inside other functions
*/


int printInt(int num);
int printStr(char * c);
int readInt(int *eP);

int fib(int n)
{
	if(n <= 1){
		return n;
	}
	else {
		return fib(n-1) + fib(n-2);
	}
}

void main()
{
	int n, i;
    printStr("Enter the number (n < 10 ) : ");
    readInt(& n);
    int a, b, c;
    a = 0;
    b = 1;
    c = n;
    for (i = 2; i <= n; i++){
        c = a + b;
        a = b;
        b = c;
    }
    int fact = fib(n);
    printStr("Fibonacci from recursion : ");
    printInt(fact);
    printStr("\n");
    printStr("Fibonacci from iterative solution : ");
    printInt(c);
    printStr("\n");
}

