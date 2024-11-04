#include<stdbool.h>
#include<stdio.h>
#include<string.h>
#include "ParserExport.h"
#include "MexprcppEnums.h"

//pow(x,2) + pow(y,2) = <CONSTANT>
static bool circle_eqn()
{
    int token_code; 
    token_code = cyylex();
    if(token_code != MATH_CPP_POW) 
    {
        yyrewind(1);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_BRACKET_START) 
    {
        yyrewind(2);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_VARIABLE) 
    {
        yyrewind(3);
        return false;
    }

    if(strcmp(lex_curr_token, "x") != 0) 
    {
        yyrewind(3);
        return false;
    }
    //pow(x,2) + pow(y,2) = <CONSTANT>

    token_code = cyylex();
    if(token_code != MATH_CPP_COMMA) 
    {
        yyrewind(4);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_INT) 
    {
        yyrewind(5);
        return false;
    }
    if(strcmp(lex_curr_token, "2") != 0) 
    {
        yyrewind(5);
        return false;
    }

    //pow(x,2) + pow(y,2) = <CONSTANT>

    token_code = cyylex();
    if(token_code != MATH_CPP_BRACKET_END)
    {
        yyrewind(6);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_PLUS)
    {
        yyrewind(7);
        return false;
    }

     //pow(x,2) + pow(y,2) = <CONSTANT>

    token_code = cyylex();
    if(token_code != MATH_CPP_POW) 
    {
        yyrewind(8);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_BRACKET_START) 
    {
        yyrewind(9);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_VARIABLE) 
    {
        yyrewind(10);
        return false;
    }

    if(strcmp(lex_curr_token, "y") != 0) 
    {
        yyrewind(10);
        return false;
    }
    //pow(x,2) + pow(y,2) = <CONSTANT>

    token_code = cyylex();
    if(token_code != MATH_CPP_COMMA) 
    {
        yyrewind(11);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_INT) 
    {
        yyrewind(12);
        return false;
    }
    if(strcmp(lex_curr_token, "2") != 0) 
    {
        yyrewind(12);
        return false;
    }

    //pow(x,2) + pow(y,2) = <CONSTANT>

    token_code = cyylex();
    if(token_code != MATH_CPP_BRACKET_END)
    {
        yyrewind(13);
        return false;
    }
    
    token_code = cyylex();
    if(token_code != MATH_CPP_EQ) 
    {
        yyrewind(14);
        return false;
    }

    token_code = cyylex();
    if(token_code != MATH_CPP_INT && token_code != MATH_CPP_DOUBLE)
    {
        yyrewind(15);
        return false;
    }

    return true;
 
}

// pow(x,2)/pow(a,2) + pow(y,2)/pow(b,2) = 1

// pow(x,2)/pow(a,2) + pow(y,2)/pow(b,2) = 1
static bool ellipse_eqn()
{
    int token_code = cyylex();

    // Check "pow("
    if (token_code != MATH_CPP_POW) 
    {
        yyrewind(1);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_START) 
    {
        yyrewind(2);
        return false;
    }

    // Check "x"
    token_code = cyylex();
    if (token_code != MATH_CPP_VARIABLE) 
    {
        yyrewind(3);
        return false;
    }

    if (strcmp(lex_curr_token, "x") != 0) 
    {
        yyrewind(3);
        return false;
    }

    // Check ",2)"
    token_code = cyylex();
    if (token_code != MATH_CPP_COMMA) 
    {
        yyrewind(4);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_INT) 
    {
        yyrewind(5);
        return false;
    }

    if (strcmp(lex_curr_token, "2") != 0) 
    {
        yyrewind(5);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_END)
    {
        yyrewind(6);
        return false;
    }

    // Check "/pow(a,2)"
    token_code = cyylex();
    if (token_code != MATH_CPP_DIV) 
    {
        yyrewind(7);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_POW) 
    {
        yyrewind(8);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_START) 
    {
        yyrewind(9);
        return false;
    }

    // Check "a"
    token_code = cyylex();
    if (token_code != MATH_CPP_VARIABLE) 
    {
        yyrewind(10);
        return false;
    }

    if (strcmp(lex_curr_token, "a") != 0) 
    {
        yyrewind(10);
        return false;
    }

    // Check ",2)"
    token_code = cyylex();
    if (token_code != MATH_CPP_COMMA) 
    {
        yyrewind(11);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_INT) 
    {
        yyrewind(12);
        return false;
    }

    if (strcmp(lex_curr_token, "2") != 0) 
    {
        yyrewind(12);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_END)
    {
        yyrewind(13);
        return false;
    }

    // Check "+"
    token_code = cyylex();
    if (token_code != MATH_CPP_PLUS)
    {
        yyrewind(14);
        return false;
    }

    // Check "pow(y,2)/pow(b,2)"
    token_code = cyylex();
    if (token_code != MATH_CPP_POW) 
    {
        yyrewind(15);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_START) 
    {
        yyrewind(16);
        return false;
    }

    // Check "y"
    token_code = cyylex();
    if (token_code != MATH_CPP_VARIABLE) 
    {
        yyrewind(17);
        return false;
    }

    if (strcmp(lex_curr_token, "y") != 0) 
    {
        yyrewind(17);
        return false;
    }

    // Check ",2)"
    token_code = cyylex();
    if (token_code != MATH_CPP_COMMA) 
    {
        yyrewind(18);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_INT) 
    {
        yyrewind(19);
        return false;
    }

    if (strcmp(lex_curr_token, "2") != 0) 
    {
        yyrewind(19);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_END)
    {
        yyrewind(20);
        return false;
    }

    // Check "/pow(b,2)"
    token_code = cyylex();
    if (token_code != MATH_CPP_DIV) 
    {
        yyrewind(21);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_POW) 
    {
        yyrewind(22);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_START) 
    {
        yyrewind(23);
        return false;
    }

    // Check "b"
    token_code = cyylex();
    if (token_code != MATH_CPP_VARIABLE) 
    {
        yyrewind(24);
        return false;
    }

    if (strcmp(lex_curr_token, "b") != 0) 
    {
        yyrewind(24);
        return false;
    }

    // Check ",2)"
    token_code = cyylex();
    if (token_code != MATH_CPP_COMMA) 
    {
        yyrewind(25);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_INT) 
    {
        yyrewind(26);
        return false;
    }

    if (strcmp(lex_curr_token, "2") != 0) 
    {
        yyrewind(26);
        return false;
    }

    token_code = cyylex();
    if (token_code != MATH_CPP_BRACKET_END)
    {
        yyrewind(27);
        return false;
    }

    // Check "="
    token_code = cyylex();
    if (token_code != MATH_CPP_EQ) 
    {
        yyrewind(28);
        return false;
    }

    // Check "1" (constant on the right side of the equation)
    token_code = cyylex();
    if (token_code != MATH_CPP_INT || strcmp(lex_curr_token, "1") != 0)
    {
        yyrewind(29);
        return false;
    }

    return true;  // Parsing successful if all checks passed
}


void Parse_Equations()
{
    bool re = circle_eqn();

    if(re)
    {
        printf("Eqn of Circle\n");
    }

    re = ellipse_eqn();

    if(re)
    {
        printf("Eqn of Ellipse\n");
    }
}