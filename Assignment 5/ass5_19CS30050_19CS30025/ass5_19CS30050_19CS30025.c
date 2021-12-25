/*
  Group number - 19
  Group Member 1 - Suryam Arnav Kalra (19CS30050)
  Group Member 2 - Kunal Singh (19CS30025)
*/


#include <stdio.h>
#include "y.tab.h"
extern "C" {
  char* yytext;
  int yyparse();
}
int main() {
  int token;
  yyparse();
  return 0;
}