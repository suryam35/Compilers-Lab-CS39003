/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/


/*
    This test files covers things as:
        1D arrays
        different loops and contionals in loops
        function calling inside other functions
*/

void insertion_sort(int arr[], int n){
 int i;
 for (i = 1; i < n; ++i)
 {
     int current = arr[i];
     int j = i-1;
     while(arr[j] > current && j >= 0){
         arr[j+1] = arr[j];
         j--;
     }
     arr[j+1] = current;
 }
}

void selection_sort(int arr[], int n){

    for (i = 0; i < n-1; ++i)
    {
        for (j = i+1; j < n; ++j)
        {
            if(arr[j] < arr[i]){
                int temp = arr[j];
                arr[j] = arr[i];
                arr[i] = temp;
            }
        }
    }
}


int main(int argc, char const *argv[])
{
    int n;
    cin >> n;
    int arr[n];
    int i;
    for (i = 0; i < n; ++i)
    {
        scanf("%d" , &arr[i]);
    }

    insertion_sort(arr, n);
    selection_sort(arr, n);

    for (i = 0; i < n; ++i)
    {
        printf("%d " , arr[i]);
    }

    return 0;
}
