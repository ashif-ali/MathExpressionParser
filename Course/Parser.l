%{
#include <stdio.h>
extern "C" int yylex();
char lex_buffer[512]; // Declaring the buffer as a char array

#include "MexprcppEnums.h"
%}

%%

"("                 { return MATH_CPP_BRACKET_START; }
")"                 { return MATH_CPP_BRACKET_END; }
">="                {return  MATH_CPP_GREATER_THAN_EQ;}
"<="                { return MATH_CPP_LESS_THAN_EQ; }
"<"                 { return MATH_CPP_LESS_THAN; }
">"                 { return MATH_CPP_GREATER_THAN; }
"="                 { return MATH_CPP_EQ; }
"!="                { return MATH_CPP_NEQ; }
"and"               { return MATH_CPP_AND; }
"or"                { return MATH_CPP_OR; }
"*"                 { return MATH_CPP_MUL; }
"+"                 { return MATH_CPP_PLUS; }
"-"                 { return MATH_CPP_MINUS; }
"/"                 { return MATH_CPP_DIV; }
","                 { return MATH_CPP_COMMA; }
"sqrt"              { return MATH_CPP_SQRT; }
"sqr"               { return MATH_CPP_SQR; }
"mmax"              { return MATH_CPP_MAX; }
"mmin"              { return MATH_CPP_MIN; }
"sin"               { return MATH_CPP_SIN; }
"cos"               { return MATH_CPP_COS; }
"pow"               { return MATH_CPP_POW; }

\n                  { return PARSER_EOL; }

"\\\n"              { /* Handle escaped newline */ }

[ ]                 { /* Ignore single spaces */ }
[\t]                { /* Ignore tabs */ }

"\\q"               { return PARSER_QUIT; }

0|-?[1-9][0-9]*     { return MATH_CPP_INT; }
-?[0-9]*\.[0-9]+    { return MATH_CPP_DOUBLE; }
[a-zA-Z0-9_]+       { return MATH_CPP_VARIABLE; }
[a-zA-Z0-9_]+\.[a-zA-Z0-9_]+ { return MATH_CPP_IDENTIFIER_IDENTIFIER; }

'[^']*'             { return MATH_CPP_STRING; }  // Single-quoted strings
\"[^"]*\"           { return MATH_CPP_STRING; }  // Double-quoted strings

.                   { /* Ignore any other character */ }

%%

int main() {
    while (1) {
        printf("Enter input: ");
        fgets(lex_buffer, sizeof(lex_buffer), stdin);

        if (lex_buffer[0] == '\n') {
            lex_buffer[0] = 0;
            continue;
        }
        
        yy_scan_string(lex_buffer);
        int token_code = yylex();

        while (token_code != PARSER_EOL) {
            printf("token_code = %d, token = %s, token_len = %d\n", token_code, yytext, yyleng);
            token_code = yylex();
        }
    }
    return 0;
}
