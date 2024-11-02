%
{
#include <stdio.h>
extern "C" int yylex();
    extern lex_buffer[512];

    int lex_buffer[512]; // Declaring the buffer

    // Declare any additional variables or functions here

#include "MexprEnums.h"
    %
}

% %
    // Regular expressions and actions go here

    \n {
        return PARSER_EOL
    }

    0|-?[1-9][0-9]* {
        return MATH_CPP_INT;
    }
    
    -?[0-9]*\.[0-9]+ {
        return MATH_CPP_DOUBLE;
    }

    [a-zA-Z0-9_]+ {
        return MATH_CPP_VARIABLE;
    }

    \b((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\b {
        return MATH_CPP_IPV4;
    }

    .{
        //ignore any other non parsable character
    }

    [ ] {
        //
    }

    .{
        printf("ignore non-parsable character - %s\n", yytext);
    }

    % %

    int main()
{
    while (1) {
        printf("Enter input: ");
        fgets(lex_buffer, sizeof(lex_buffer), stdin);

        if (lex_buffer[0] == '\n') {
            lex_buffer[0] = 0;
            continue;
        }
        yy_scan_string(lex_buffer)
    }
    return 0;
}
