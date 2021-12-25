/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/

/*
	This test files covers things as:
		Function declartions
		different looping statements(for, while, do while)
		if else conditionals
		different type of parameter passing to the functions (1D array, integer)
		function calling inside other functions
		1D arrays
*/


int mergesort(int arr[], int l, int r);
int merge(int arr[], int l, int m, int r);

int findinv(int a[], int n) {
	return mergesort(a, 0, n);
}

void main() {
	int n, * a, i;
	printf("Enter nuber of elements : ");
	scanf("%d", & n);
	printf("Enter %d elements : ", n);
	a = n + 1;
	for (i = 0; i < n; i++)
		scanf("%d", & a[i]);
	printf("Number of inversion = %d", findinv(a, n));

}

int merge(int arr[], int l, int m, int r) {
	int len, i, j, k, * c, count = 0;
	len = r - l + 1;
	c = len;
	i = 0;
	j = l;
	k = m;
	while (j <= m - 1 && k <= r) {
		if (arr[j] <= arr[k]) {
		  c[i++] = arr[j++];

		} else {
		  c[i++] = arr[k++];
		  count += m - j;

		}

	}

	while (j <= m - 1) {
		c[i++] = arr[j++];
	}

	while (k <= r) {
		c[i++] = arr[k++];
	}
	i = 0;
	while (l <= r) {
		arr[l++] = c[i++];
	}

  	return count;
}

int mergesort(int arr[], int l, int r) {
	int count = 0;
	int m = (l + r) / 2;
	if (l < r) {
		count += mergesort(arr, l, m);
		count += mergesort(arr, m + 1, r);
		count += merge(arr, l, m + 1, r);
	}

  return count;
}