%{

	/*

        Assignment No - 4
        Group Member 1 - Suryam Arnav Kalra (19CS30050)
        Group Member 2 - Kunal Singh (19CS30025)

    */
#include "y.tab.h"

%}

%option noyywrap

/* Regex Definitions */
KEYWORD                     "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary"
DIGIT                       [0-9]
IDENTIFIER_NONDIGIT         [a-zA-Z_]
IDENTIFIER                  {IDENTIFIER_NONDIGIT}({IDENTIFIER_NONDIGIT}|{DIGIT})*
NONZERO_DIGIT               [1-9]
INTEGER_CONSTANT            {NONZERO_DIGIT}{DIGIT}*|0
DIGIT_SEQUENCE              {DIGIT}+
FRACTIONAL_CONSTANT         (({DIGIT_SEQUENCE})?\.{DIGIT_SEQUENCE})|(({DIGIT_SEQUENCE})\.)
EXPONENT_PART               (([eE])({SIGN}?)){DIGIT_SEQUENCE}
FLOATING_CONSTANT           ({FRACTIONAL_CONSTANT}({EXPONENT_PART})?)|({DIGIT_SEQUENCE}{EXPONENT_PART})
SIGN                        [+-]
ENUMERATION_CONSTANT        {IDENTIFIER}
ESCAPE_SEQUENCE             \\['"?\\abfnrtv]
C_CHAR                      {ESCAPE_SEQUENCE}|[^'\\\n]
C_CHAR_SEQUENCE             {C_CHAR}+
CHARACTER_CONSTANT          '{C_CHAR_SEQUENCE}'
CONSTANT                    {INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{ENUMERATION_CONSTANT}|{CHARACTER_CONSTANT}
S_CHAR                      {ESCAPE_SEQUENCE}|[^"\\\n]
S_CHAR_SEQUENCE             {S_CHAR}+
STRING_LITERAL              \"{S_CHAR_SEQUENCE}\"
PUNCTUATOR                  "["|"]"|"("|")"|"{"|"}"|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
COMMENT                     ("/*"([^*]|\*+[^*/])*\*+"/")|("//".*)
backother  		    [ \t\v\n\f]
%%
"auto"                      {return AUTO;}
"break"                     {return BREAK;}
"case"                      {return CASE;}
"char"                      {return CHAR;}
"const"                     {return CONST;}
"continue"                  {return CONTINUE;}
"default"                    {return DEFAULT;}
"do"                        {return DO;}
"double"                    {return DOUBLE;}
"else"                      {return ELSE;}
"enum"                      {return ENUM;}
"extern"                    {return EXTERN;}
"float"                     {return FLOAT;}
"for"                       {return FOR;}
"goto"                      {return GOTO;}
"if"                        {return IF;}
"inline"                    {return INLINE;}
"int"                       {return INT;}
"long"                      {return LONG;}
"register"                  {return REGISTER;}
"restrict"                  {return RESTRICT;}
"return"                    {return RETURN;}
"short"                     {return SHORT;}
"signed"                    {return SIGNED;}
"sizeof"                    {return SIZEOF;}
"static"                    {return STATIC;}
"struct"                    {return STRUCT;}
"switch"                    {return SWITCH;}
"typedef"                   {return TYPEDEF;}
"union"                     {return UNION;}
"unsigned"                  {return UNSIGNED;}
"void"                      {return VOID;}
"volatile"                  {return VOLATILE;}
"while"                     {return WHILE;}
"_Bool"                      {return BOOL;}
"_Complex"                   {return COMPLEX;}
"_Imaginary"                 {return IMAGINARY;}
{IDENTIFIER}                {return IDENTIFIER;}
{INTEGER_CONSTANT}          {return INTEGER_CONSTANT;}
{FLOATING_CONSTANT}         {return FLOATING_CONSTANT;}
{ENUMERATION_CONSTANT}      {return ENUMERATION_CONSTANT;}
{CHARACTER_CONSTANT}        {return CHARACTER_CONSTANT;}
{ESCAPE_SEQUENCE}           {return ESCAPE_SEQUENCE;}
{STRING_LITERAL}            {return STRING_LITERAL;}
"["                         {return LEFT_SQUARE_BRACKET;}
"]"                         {return RIGHT_SQUARE_BRACKET;}
"{"                         {return LEFT_CURLY_BRACKET;}
"}"                         {return RIGHT_CURLY_BRACKET;}
"("                         {return LEFT_ROUND_BRACKET;}
")"                         {return RIGHT_ROUND_BRACKET;}
"."                         {return DOT;}
"->"                        {return LEFT_POINTER;}
"*="                        {return STAR_EQUAL;}
"/="                        {return BACKSLASH_EQUAL;}
"+="                        {return PLUS_EQUAL;}
"-="                        {return MINUS_EQUAL;}
"<<="                       {return LESS_LESS_EQUAL;}
">>="                       {return GREAT_GREAT_EQUAL;}
"&="                        {return AMP_EQUAL;}
"%="                        {return PERCENT_EQUAL;}
"|="                        {return LINE_EQUAL;}
"^="                        {return UPARROW_EQUAL;}
"<="                        {return LESS_EQUAL;}
">="                        {return GREAT_EQUAL;}
"=="                        {return EQUAL_EQUAL;}
"!="                        {return EXCL_EQUAL;}
"++"                        {return PLUS_PLUS;}
"--"                        {return MINUS_MINUS;}
"&&"                        {return AMPERSAND_AMPERSAND;}
"||"                        {return LINE_LINE;}
"&"                         {return AMPERSAND;}
"|"                         {return LINE;}
"^"                         {return UP_ARROW;}
"+"                         {return PLUS;}
"-"                         {return MINUS;}
"*"                         {return STAR;}
"/"                         {return BACK_SLASH;}
"%"                         {return PERCENTAGE;}
"~"                         {return TILDA;}
"!"                         {return EXCLAMATION;}
"<<"                        {return LESS_LESS;}
">>"                        {return GREAT_GREAT;}
"<"                         {return LESS;}
">"                         {return GREAT;}
"?"                         {return QUEST_MARK;}
":"                         {return COLON;}
";"                         {return SEMI_COLON;}
"..."                       {return DOTDOTDOT;}
"="                         {return EQUAL;}
","                         {return COMMA;}
"#"                         {return HASH;}

{COMMENT}                   { /*empty*/}

{backother}		    { /* whitespace separates tokens */ }
.                           {return ERROR;}
%%
