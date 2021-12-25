/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
	This test files covers things as:
		arithmetic operations
		1D arrays
		nested for loops
		function calling inside other functions
*/


int findinversion(int a[],int n)
{
	int i,j,count=0;

	for(i=0;i<n;i++)
	{
	  	for(j=i+1;j<n;j++)
	  	{
	       if(a[i]>a[j])
	       count++;
	  	}
	}
 return count;
}

void main()
{
	int n;
	printf("Enter nuber of elements : ");
	scanf("%d",&n);
	printf("Enter %d elements : ",n);
	int *arr,i;
	arr=n+1;
	for(i=0;i<n;i++)
	scanf("%d",&arr[i]);
	printf("Number of inversion = %d",findinversion(arr,n));
	int a, b;
	cin >> a >> b;
 	int demo_array[15];
	demo_array[0]=1;
	demo_array[1]=(a+b);
	demo_array[2]=a+b;
	demo_array[3]=a*b;
	demo_array[4]=a++;
	demo_array[5]=--b;
	demo_array[6]=!b;
	demo_array[7]=a/b;
	demo_array[8]=a%b;
	demo_array[9]=a>>b;
	demo_array[10]=a&b;
	demo_array[11]=a^b;
	demo_array[12]=a|b;
	demo_array[14]=a<<b;
}

