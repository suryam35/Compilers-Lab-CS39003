/*

        Assignment No - 4
        Group Member 1 - Suryam Arnav Kalra (19CS30050)
        Group Member 2 - Kunal Singh (19CS30025)

*/

#include<stdio.h>
#include "y.tab.h"
int main(){
  yydebug=1;
  yyparse();
  return 0;
}

