
/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        different way of passing arguments to function
        unary operation in arguments of a function
        function calling inside other functions
*/


int printStr(char *c);
int printInt(int i);
int readInt(int *eP);

int gcd(int a, int b){
    if(a == 0){
      return b;
    }
    if(b == 0){
      return a;
    }

    if(a == b){
      return a;
    }

    if(a > b){
      return gcd(a-b, b);
    }
    return gcd(a, b-a);
}
  

int main() 
{ 
    int a, b;
    printStr("Enter a : ");
    readInt(&a);
    printStr("Enter b : ");
    readInt(&b);
    int x = gcd(a,b);
    printStr("GCD of two number is: ");
    printInt(x);
    printStr("\n");
}
