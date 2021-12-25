/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/


/*
    This test files covers things as:
        1D array and direct intialization
        main function with arguments
*/

     
int array_rotation_right(int arr[], int n)    
{    
    int arr[] = {1, 2, 3, 4, 5};     
    int length = 5;    
    int n = 3;    
    int i;
    printf("Original array: \n");    
    for (i = 0; i < length; i++) {     
        printf("%d ", arr[i]);     
    }     
        
    for(i = 0; i < n; i++){    
        int j, last;    
        last = arr[length-1];    
        
        for(j = length-1; j > 0; j--){    
            arr[j] = arr[j-1];    
        }    
        arr[0] = last;    
    }    
        
    printf("\n");    
        
    printf("Array after right rotation: \n");    
    for(i = 0; i< length; i++){    
        printf("%d ", arr[i]);    
    }    
    return 0;    
}  


int main(int argc, char const *argv[])
{
    int n;
    cin >> n;
    int arr[n];
    int i;
    for (i = 0; i < n; ++i)
    {
        cin >> arr[i];
    }

    for (i = 0; i < n; ++i)
    {
        cout<<arr[i]<<" ";
    }

    return 0;
}
