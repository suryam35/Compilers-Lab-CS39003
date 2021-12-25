/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
	This test files covers things as:
		2D arrays
		1D arrays
		nested loops
		different looping statements(for, while)
		pointers
		diffrent ways to write operations using operator & operands
		diffrent datatypes and their priting (double, int, string)
		if else conditionals
		function calling inside other functions
*/

void func1(){
	int n, i; 
 	double num, den;

	for(num=1, n=1; n<=50; n++){
    	num = num*n;
    	for(i=1, den=1; i<=n; i++)
      		den = den*n;
    	printf("n=%2d: %12.10f\n", n, num/den);
  }
}


void func2(){
	int year, leap;
    
    printf("Enter the year: ");
    scanf("%d", &year);

    if (year % 400 == 0)
      leap = 1;
    else if (year % 100 == 0)
      leap = 0;
    else if (year % 4 == 0)
      leap = 1;
    else leap = 0;

    if (leap)
      printf("Year %d is a leap year.\n\n", year);
    else 
      printf("Year %d is not a leap year.\n\n", year);
}


int func3(int x, int n){
  	int i, res=1;
  	for(i=1; i<=n; i++)
    	res *= x;
  	return res;
}

void func4(){
	int p, q = 0, r, d, s, flag=0;
  
  	printf("\nEnter p: ");
  	scanf("%d", &p);
  
  	for(r=p; r>0; r=r/10){
    	d = r%10;
    	q = q*10 + d;
  	}  

  	printf("Reverse number = %d\n", q);
  	printf("Common divisors: ");
  
  	for(r=2; r<=s; r++)
    	if(p%r==0 && q%r==0)
      	printf("%d, ", r);
      	flag=1;
    
  	if(flag == 0) printf("none.\n\n");
  	else printf("\b\b.\n\n");
  	return 0;
}

int main(){
  	int s, t, n=1;
  	printf("Enter value for s and t: ");
  	scanf("%d%d", &s, &t);
  
  	while(xPowN(s,n) < t)
    	n++;

    int dp[50][50];

    for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)  
			dp[i][j]= t*j; 
	}
  
  	printf("The max value of n: %d\n", n-1);
  
  return 0;
}




