/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        1D arrays
        nested loops (for and while)
        different looping statements(for, while)
        value changing inside 1D array
*/


int printInt(int num);
int printStr(char * c);
int readInt(int *eP);

// The time complexity is O(N^2)
int bubble_sort(int arr[], int n){
    int counter = 0;
    while(counter < n-1){
        int i;
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
    return 0;
}

int main(){
    int n, i;
    int arr[100];
    printStr("Enter number of elements : ");
    readInt(&n);
    for (i = 0; i < n; i++){
        int tempo;
        readInt(&tempo);
        arr[i] = tempo;
    }
    

    int z = bubble_sort(arr, n);
    printStr("The array after sorting is : ");
    for (i = 0; i < n; ++i)
    {
        int x = arr[i];
        printInt(x);
        printStr(" ");
    }
    printStr("\n");
    return 0;
}
