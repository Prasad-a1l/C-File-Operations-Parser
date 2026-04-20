%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror(const char *s);
extern FILE *yyin;

FILE *fp = NULL;

typedef struct {
    int id;
    char name[50];
} Record;

Record rec;
%}

%union {
    int num;
    char* str;
}

%token FOPEN FCLOSE FPRINTF FSCANF FWRITE FREAD FSEEK FTELL REWIND
%token <num> NUMBER
%token <str> STRING
%token ID

%%

program:
    statements
;

statements:
      statements statement
    | statement
;

statement:
      open_stmt
    | write_stmt
    | read_stmt
    | fwrite_stmt
    | fread_stmt
    | fseek_stmt
    | ftell_stmt
    | rewind_stmt
    | close_stmt
;

open_stmt:
    ID '=' FOPEN '(' STRING ',' STRING ')' ';'
    {
        char file[100], mode[10];
        sscanf($5, "\"%[^\"]\"", file);
        sscanf($7, "\"%[^\"]\"", mode);

        fp = fopen(file, mode);

        if (fp)
            printf("Opened file %s (%s)\n", file, mode);
        else
            printf("Error opening file\n");
    }
;

write_stmt:
    FPRINTF '(' ID ',' STRING ')' ';'
    {
        if (!fp) printf("File not open\n");
        else {
            char text[100];
            sscanf($5, "\"%[^\"]\"", text);
            fprintf(fp, "%s\n", text);
            printf("Written: %s\n", text);
        }
    }
;

read_stmt:
    FSCANF '(' ID ',' STRING ',' ID ')' ';'
    {
        if (!fp) printf("File not open\n");
        else {
            char buffer[100];
            fscanf(fp, "%s", buffer);
            printf("Read: %s\n", buffer);
        }
    }
;

fwrite_stmt:
    FWRITE '(' NUMBER ',' STRING ')' ';'
    {
        if (!fp) printf("File not open\n");
        else {
            rec.id = $3;
            sscanf($5, "\"%[^\"]\"", rec.name);

            fwrite(&rec, sizeof(rec), 1, fp);
            printf("Binary write: ID=%d Name=%s\n", rec.id, rec.name);
        }
    }
;

fread_stmt:
    FREAD '(' ')' ';'
    {
        if (!fp) printf("File not open\n");
        else {
            rewind(fp);
            printf("Reading binary records:\n");

            while (fread(&rec, sizeof(rec), 1, fp)) {
                printf("ID=%d Name=%s\n", rec.id, rec.name);
            }
        }
    }
;

fseek_stmt:
    FSEEK '(' NUMBER ')' ';'
    {
        if (!fp) printf("File not open\n");
        else {
            fseek(fp, $3, SEEK_SET);
            printf("Moved file pointer to %d\n", $3);
        }
    }
;

ftell_stmt:
    FTELL '(' ')' ';'
    {
        if (!fp) printf("File not open\n");
        else {
            printf("Current position: %ld\n", ftell(fp));
        }
    }
;

rewind_stmt:
    REWIND '(' ')' ';'
    {
        if (!fp) printf("File not open\n");
        else {
            rewind(fp);
            printf("Pointer reset to start\n");
        }
    }
;

close_stmt:
    FCLOSE '(' ID ')' ';'
    {
        if (fp) {
            fclose(fp);
            fp = NULL;
            printf("File closed\n");
        } else {
            printf("No file open\n");
        }
    }
;

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            printf("Cannot open input file\n");
            return 1;
        }
    }
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Syntax Error: %s\n", s);
    return 0;
}