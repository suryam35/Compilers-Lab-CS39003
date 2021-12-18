// #include<stdio.h>
void swap(int *a , int *b);
int parent_node(int i);
int left_child(int i);
int right_child(int i);
void max_heapify(int a[] , int n , int i);
void build_max_heap(int a[] , int n);
void heap_sort(int a[] , int n);
int maximum(int a[] , int n);
int extract_max(int a[] , int *n);
void increase_value(int a[] , int n , int val , int index);
void insert_value(int a[] , int *n , int val);
void main()
{
    /*

        Assignment No - 4
        Group Member 1 - Suryam Arnav Kalra (19CS30050)
        Group Member 2 - Kunal Singh (19CS30025)

    */
    int n;
    scanf("%d" , &n);
    int a[n];
    for(int i = 0 ; i < n ; i++)
    {
        scanf("%d" , a+i);
    }
    build_max_heap(a , n);                      
    heap_sort(a , n);
    for(int i = 0 ; i < n ; i++)
    {
        printf("%d " , a[i]);
    }
    
    

    int a[1000];
    int len = 0;
    insert_value(a , &len , 4);
    insert_value(a , &len , 8);
    insert_value(a , &len , 1);
    insert_value(a , &len , 10);
    printf("%d\n" , maximum(a , len));               // implementation of priority queue
    increase_value(a , len , 12 , 1);
    for(int i = 0 ; i < len ; i++)
    {
        printf("%d ", a[i]);
    }
}
void insert_value(int a[] , int *n , int val)
{
    (*n)++;
    a[(*n) - 1] = -1 ; // assuming my heap contains only positive integers
    increase_value(a , *n , val , *n - 1);
}
void increase_value(int a[] , int n , int val , int index)
{
    if(a[index] >= val)
    {
        printf("can't increase");
        return;
    }
    a[index] = val;
    while(index > 0 && a[parent_node(index)] < a[index])
    {
        swap(&a[index] , &a[parent_node(index)]);
        index = parent_node(index);
    }
}
int extract_max(int a[] , int *n)
{
    if(*n == 0)
    {
        printf("can't extract");
        return -1;
    }
    int max = a[0];
    swap(&a[0] , &a[(*n) - 1]);
    (*n)--;
    max_heapify(a , *n , 0);
    return max;
}
int maximum(int a[] , int n)
{
    return a[0];
}
void heap_sort(int a[] , int n)
{
    int length = n - 1;
    for(int i = 0 ; i < n ; i++)
    {
        swap(&a[0] , &a[length]);
        length--;
        max_heapify(a , length+1 , 0);
    }
}
void build_max_heap(int a[] , int n)
{
    for(int i = (n-1)/2 ; i >= 0 ; i--)
    {
        max_heapify(a , n , i);
    }
}
void swap(int *a , int *b)
{
    int temp;
    temp = *a;
    *a = *b;
    *b = temp;
}
void max_heapify(int a[] , int n , int i)
{
    int l = left_child(i);
    int r = right_child(i);
    int largest = i;
    if(l < n && a[i] < a[l])
    {
        largest = l;
    }
    if(r < n && a[largest] < a[r])
    {
        largest = r;
    }
    if(largest != i)
    {
        swap(&a[i] , &a[largest]);
        max_heapify(a , n , largest);
    }
}
int max_of_max_heap(int a[] , int n)
{
    return a[0];
}
int right_child(int i)
{
    return 2*i + 2;
}
int left_child(int i)
{
    return 2*i + 1;
}
int parent_node(int i)
{
    if(i == 0)
    {
        return 0;
    }
    else
    {
        return (i-1)/2;
    }
}