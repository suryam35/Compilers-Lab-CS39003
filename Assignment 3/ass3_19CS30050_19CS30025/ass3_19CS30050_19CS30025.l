%{

    #define DOT 1
    #define LEFT_SQUARE_BRACKET 2
    #define RIGHT_SQUARE_BRACKET 3
    #define LEFT_ROUND_BRACKET 4
    #define FLOATING_CONSTANT 5
    #define ENUMERATION_CONSTANT 6
    #define CHARACTER_CONSTANT 7
    #define ESCAPE_SEQUENCE 8
    #define STRING_LITERAL 9
    #define PUNCTUATOR 10
    #define COMMENT  11
    #define GREAT 12
    #define LESS_EQUAL 13 
    #define GREAT_EQUAL 14
    #define EQUAL_EQUAL 15
    #define EXCL_EQUAL 16
    #define UP_ARROW 17
    #define LINE 18
    #define AMPERSAND_AMPERSAND 19 
    #define LINE_LINE 20
    #define QUEST_MARK 21
    #define COLON 22
    #define SEMI_COLON 23 
    #define DOTDOTDOT 24
    #define EQUAL 25
    #define STAR_EQUAL 26 
    #define BACKSLASH_EQUAL 27
    #define PERCENT_EQUAL 28
    #define PLUS_EQUAL 29
    #define MINUS_EQUAL 30
    #define LESS_LESS_EQUAL 31 
    #define GREAT_GREAT_EQUAL 32
    #define AMP_EQUAL 33
    #define UPARROW_EQUAL 34 
    #define LINE_EQUAL 35
    #define LEFT_POINTER 36
    #define PLUS_PLUS 37
    #define MINUS_MINUS 38
    #define AMPERSAND 39
    #define STAR 40
    #define PLUS 41
    #define MINUS 42
    #define SIGNED  43
    #define SIZEOF 44
    #define STATIC 45
    #define STRUCT 46
    #define SWITCH 47
    #define TYPEDEF 48
    #define UNION 49
    #define DEFAULT 50
    #define TILDA 51
    #define EXCLAMATION 52
    #define BACK_SLASH 53
    #define PERCENTAGE 54
    #define CHAR 55
    #define CONST 56
    #define CONTINUE 57 
    #define FLOAT 58
    #define FOR 59
    #define GOTO 60
    #define IF 61
    #define INLINE 62 
    #define INT 63
    #define LONG 64
    #define LESS_LESS 65
    #define GREAT_GREAT 66
    #define COMMA 67
    #define HASH 68
    #define AUTO 69
    #define RIGHT_ROUND_BRACKET 70 
    #define LEFT_CURLY_BRACKET 71
    #define RIGHT_CURLY_BRACKET 72
    #define LESS 73
    #define KEYWORD 74 
    #define IDENTIFIER 75 
    #define INTEGER_CONSTANT 76 
    #define BREAK 77
    #define REGISTER 78 
    #define RESTRICT 79
    #define RETURN 80
    #define SHORT 81
    #define DO 82
    #define DOUBLE 83 
    #define ELSE 84
    #define ENUM 85
    #define EXTERN 86
    #define UNSIGNED 87
    #define VOID 88
    #define VOLATILE 89
    #define WHILE 90
    #define BOOL 91
    #define COMPLEX 92
    #define IMAGINARY 93
    #define ERROR 100




%}
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
{COMMENT}                   {return COMMENT;}
"."         			    {return DOT;}
"["                         {return LEFT_SQUARE_BRACKET;}
"]"                         {return RIGHT_SQUARE_BRACKET;}
"("                         {return LEFT_ROUND_BRACKET;}
")"                         {return RIGHT_ROUND_BRACKET;}
"{"                         {return LEFT_CURLY_BRACKET;}
"}"                         {return RIGHT_CURLY_BRACKET;}
"->"                        {return LEFT_POINTER;}
"++"                        {return PLUS_PLUS;}
"--"                        {return MINUS_MINUS;}
"&"                         {return AMPERSAND;}
"*"                         {return STAR;}
"+"                         {return PLUS;}
"-"                         {return MINUS;}
"~"                         {return TILDA;}
"!"                         {return EXCLAMATION;}
"/"                         {return BACK_SLASH;}
"%"                         {return PERCENTAGE;}
"<<"                        {return LESS_LESS;}
">>"                        {return GREAT_GREAT;}
"<"                         {return LESS;}
">"                         {return GREAT;}
"<="                        {return LESS_EQUAL;}
">="                        {return GREAT_EQUAL;}
"=="                        {return EQUAL_EQUAL;}
"!="                        {return EXCL_EQUAL;}
"^"                         {return UP_ARROW;}
"|"                         {return LINE;}
"&&"                        {return AMPERSAND_AMPERSAND;}
"||"                        {return LINE_LINE;}
"?"                         {return QUEST_MARK;}
":"                         {return COLON;}
";"                         {return SEMI_COLON;}
"..."                       {return DOTDOTDOT;}
"="                         {return EQUAL;}
"*="                        {return STAR_EQUAL;}
"/="                        {return BACKSLASH_EQUAL;}
"%="                        {return PERCENT_EQUAL;}
"+="                        {return PLUS_EQUAL;}
"-="                        {return MINUS_EQUAL;}
"<<="                       {return LESS_LESS_EQUAL;}
">>="                       {return GREAT_GREAT_EQUAL;}
"&="                        {return AMP_EQUAL;}
"^="                        {return UPARROW_EQUAL;}
"|="                        {return LINE_EQUAL;}
","                         {return COMMA;}
"#"                         {return HASH;}




{backother}		    { /* whitespace separates tokens */ }
.                           {return ERROR;}
%%
