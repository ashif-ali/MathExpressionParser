%{
#include <stdio.h>


typedef struct lex_data_ {
    int token_code;
    int token_len;
    char* token_val;
} lex_data_t;

#define MAX_MEXPR_LEN 512
#define MAX_STRING_SIZE 512

typedef struct stack_ {
    int top;
    lex_data_t data[MAX_MEXPR_LEN];
} stack_t


extern "C" int yylex();

extern char lex_buffer[MAX_STRING_SIZE];
extern stack_t undo_stack;
extern int cyylex();
extern void yyrewind(int n);
extern char* curr_ptr;

stack_t undo_stack = {-1, {0,0,0}};

char lex_buffer[MAX_STRING_SIZE]; // Declaring the buffer as a char array
char* curr_ptr = lex_buffer;

char* lex_curr_token;
int lex_curr_token_len;

static void lex_push(lex_data_t lex_data) {
    assert(undo_stack.top < MAX_MEXPR_LEN - 1);
    undo_stack.data[++undo_stack.top] = lex_data; 
    lex_curr_token = (char*)lex_data.token_val;
}

static lex_data_t lex_pop() {
    assert(undo_stack.top > -1);
    lex_data_t res = undo_stack[undo_stack.top];
    undo_stack.top--;

    if(undo_stack.top > -1) {
        lex_data_t stck_top_lexd = undo_stack.data[undo_stack.top];
        lex_curr_token = (char*) stck_top_lexd.token_val;
        lex_curr_token_len = stck_top_lexd.token_len;
    }

    return res;
}

static void process_white_space(int n)
{
    lex_data_t lex_data;
    curr_ptr += n;
    lex_data.token_code = PARSER_WHITE_SPACE;
    lex_data.token_len = n;
    lex_data.token_val = NULL;
    lex_push(lex_data);
}

int cyylex() 
{
    int token_code = yylex();
    lex_data_t lex_data;
    lex_data.token_code = token_code;
    lex_data.token_len = yyleng;
    curr_ptr += yyleng;
    lex_data.token_val = (char*)calloc(1, yyleng + 1);
    strncpy(lex_data.token_val, yytext, yyleng + 1)
    lex_push(lex_data);
    return token_code;
}

void yyrewind(int n) 
{
    if(n <= 0) return;
    if(curr_ptr == lex_buffer) return;
    int data_len = 0;
    lex_data_t lex_data;
    while(n)
    {
        lex_data = lex_pop();
        data_len += lex_data.token_len;
        if(lex_data.token_code == PARSER_WHITE_SPACE)
        {
            continue;
        }
        n--;
        lex_data.token_code = 0;
        lex_data.token_val = 0;
    }
    curr_ptr -= data_len;
    yy_scan_string(curr_ptr);
}

#include "MexprcppEnums.h"
%}

%%

"("                 { return MATH_CPP_BRACKET_START; }
")"                 { return MATH_CPP_BRACKET_END; }
">="                { return  MATH_CPP_GREATER_THAN_EQ;}
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

[ ]                 { process_white_space(1) }
[\t]                { process_white_space(4) }

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
