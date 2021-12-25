/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
    This test files covers things as:
        recursion
        1D arrays
        nested if else statements
        function calling inside other functions
*/


int printInt(int num);
int printStr(char * c);
int readInt(int *eP);

int ternary_search(int arr[], int start, int end, int key){
    int mid1 = start + (end - start)/3;
    int mid2 = end - (end - start)/3;
    int compa = start;
    int compb = end;
    if(compa > compb){
        return -1;
    }
    else if(key == arr[mid1]){
        return mid1;
    }
    else if(key == arr[mid2]){
        return mid2;
    }
    else if(key < arr[mid1]){
        return ternary_search(arr, start, mid1 - 1, key);
    }
    else if(key > arr[mid2]){
        return ternary_search(arr, mid2 + 1, end, key);
    }
    else{
        return ternary_search(arr, mid1+1, mid2-1, key);
    }
    return -1;
}

int main()
{
    int n;
    // scanf("%d", &n);
    printStr("Enter the number of Elements in the array (< 100) : ");
    readInt(&n);
    int arr[100];
    int i;
    printStr("Enter the array Elements in sorted ascending order\n");
    for (i = 0; i < n; ++i)
    {
        int tempo;
        readInt(&tempo);
        arr[i] = tempo;
    }
    printStr("Enter the Element you want to search : ");
    int ele;
    readInt(&ele);
    printStr("\n");
    int x = ternary_search(arr, 0, n-1, ele);
    if(x == -1){
        printStr("Element not found");
    }
    else{
        printStr("Element is present in array");
    }

    return 0;
}




