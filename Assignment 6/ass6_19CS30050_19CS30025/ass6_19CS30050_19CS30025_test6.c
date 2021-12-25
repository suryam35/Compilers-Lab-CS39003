/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        different arithmetic operation(%, * , /)
*/


int printStr(char *c);
int printInt(int i);
int readInt(int *eP);

int binpow(int a, int b){
    int ans = 1;

    int temp = a;
    int temp2 = b;

    while(temp2 != 0){
        if(temp2 % 2 == 1){
            ans = ans * temp;
        }
        temp = temp * temp;
        temp2 = temp2/2;
    }

    return ans;
}
  
int main() 
{ 
    int a, b;
    printStr("Enter a : ");
    readInt(&a);
    printStr("Enter b : ");
    readInt(&b);
    int x = binpow(a,b);
    printStr("a raised to the power b is: ");
    printInt(x);
    printStr("\n");
}
