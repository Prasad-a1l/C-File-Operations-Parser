%{
#include "parser.tab.h"
#include <string.h>
%}

%%
"fopen"    { return FOPEN; }
"fclose"   { return FCLOSE; }
"fprintf"  { return FPRINTF; }
"fscanf"   { return FSCANF; }
"fwrite"   { return FWRITE; }
"fread"    { return FREAD; }
"fseek"    { return FSEEK; }
"ftell"    { return FTELL; }
"rewind"   { return REWIND; }

[0-9]+     { yylval.num = atoi(yytext); return NUMBER; }

\"[^\"]*\" { yylval.str = strdup(yytext); return STRING; }

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

"="        { return '='; }
","        { return ','; }
";"        { return ';'; }
"("        { return '('; }
")"        { return ')'; }

[ \t\n]    ;

%%

int yywrap() { return 1; }