/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
	This test files covers things as:
		recursive function calls
		1D arrays
		nested conditionals (if, else if, else)
		function calling inside other functions
*/


int ternary_search(int arr[], int start, int end, int key){
	int mid1 = start + (end - start)/3;
	int mid2 = end - (end - start)/3;
	if(key == arr[mid1]){
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
	scanf("%d", &n);
	int arr[n];
	int i;
	for (i = 0; i < n; ++i)
	{
		printf("%d", arr[i]);
	}

	ternary_search(arr, 0, n-1, 2);

	return 0;
}


