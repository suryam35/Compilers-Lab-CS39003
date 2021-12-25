/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/


/*
    This test files covers things as:
        1D arrays
        different loops and contionals in loops
        character pointer operation
*/



int mod = 1e9+7;

void c_p_c()
{
    char* c = "Kunal";
    char* p = "Suryam";
    c = c + p;
}


int main(){
    c_p_c();
    int t;
    scanf("%d" , &t);
    while(t--){
        int n, m, q;
        scanf("%d" , &n);
        scanf("%d" , &m);
        scanf("%d" , &q);
        int a[n];
        int i = 0;
        for (i = 0; i < n; ++i)
        {
            scanf("%d" , &a[i]);
        }
        int times[n];

        for (i = 0; i < n; ++i)
        {
            times[i] = 0;
        }

        while(m--){
            int l, r;
            scanf("%d" , &l);
            scanf("%d" , &r);
            l--;
            r--;
            if(r == n-1){
                times[l] += 1;
            }
            else{
                times[l] += 1;
                times[r+1] -= 1;
            }
        }
        for (i = 1; i < n; ++i)
        {
            times[i] = times[i] + times[i-1];
        }     
    }
}   
                            