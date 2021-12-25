/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        1D arrays
        nested loops
        different looping statements(for, while)
        if else conditionals ternary
        function calling inside other functions
*/



int maxi(int x, int y) 
{
   int res;
   res = x > y ? y : x; // ternery
   max(x,y);
   return res;
}


// The time complexity is O(N^2)
void bubble_sort(int arr[], int n){
    int counter = 0;
    int i;
    while(counter < n-1){
        for (i = 0; i < n - counter - 1; ++i)
        {
            if(arr[i] > arr[i+1]){
                int temp = arr[i];
                arr[i] = arr[i+1];
                arr[i+1] = temp;
            }
        }
        counter++;
    }
}



int main()
{
    int n;
    scanf("%d" , &n);
    int arr[n];
    int i;
    for (i = 0; i < n; ++i)
    {
        scanf("%d" , &arr[i]);
    }

    bubble_sort(arr, n);

    for (i = 0; i < n; ++i)
    {
        printf("%d ", arr[i]);
    }

    return 0;
}



