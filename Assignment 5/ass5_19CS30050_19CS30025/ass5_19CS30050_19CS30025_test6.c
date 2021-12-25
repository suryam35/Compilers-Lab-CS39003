/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/


/*
    This test files covers things as:
        Recurcive calls
        1D arrays
        different looping statements(for, while)
        if else conditionals
        function calling inside other functions
*/

void merge(int arr[], int l, int mid, int r){
 int i = 0;
 int n1 = mid - l + 1;
 int n2 = r - mid;
 int a[n1];
 int b[n2];
 for (i = 0; i < n1; ++i)
 {
     a[i] = arr[l+i];
 }
 for (i = 0; i < n2; ++i)
 {
     b[i] = arr[mid + 1 + i];
 }
 int i = 0;
 int j = 0;
 int k = l;
 while(i < n1 && j < n2){
     if(a[i] < b[j]){
         arr[k] = a[i];
         k++;
         i++;
     }
     else{
         arr[k] = b[j];
         k++;
         j++;
     }
 }

 while(i < n1){
     arr[k] = a[i];
     k++;
     i++;
 }
 while(j < n2){
     arr[k] = b[j];
     k++;
     j++;
 }
}


void mergeSort(int arr[], int l, int r){

 if(l < r){
     int mid = (l+r)/2;
     mergeSort(arr, l, mid);
     mergeSort(arr, mid + 1, r);
     merge(arr, l, mid, r);
 }
}

int main(){
 return 0;
}





