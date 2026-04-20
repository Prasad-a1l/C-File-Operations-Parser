# Compiler Design Project - File Operations Parser

## Overview
This project is a simple compiler implementation using Lex (Flex) and Yacc (Bison) to parse and process file operation statements in a C-like syntax. It recognizes keywords for file operations such as `fopen`, `fclose`, `fprintf`, `fscanf`, `fwrite`, `fread`, `fseek`, `ftell`, and `rewind`.

## Features
- Lexical analysis with Flex for tokenizing input
- Syntax analysis with Bison for parsing file operation statements
- Support for numbers, strings, and identifiers
- Basic error handling

## Files
- `lexer.l`: Lex specification for the lexer
- `parser.y`: Yacc specification for the parser
- `test.c`: Test file or example input
- `hero.dat`: Data file
- `dat file/`: Directory containing additional data files
- Generated files (not included in repo):
  - `lex.yy.c`: Generated lexer code
  - `parser.tab.c` and `parser.tab.h`: Generated parser code
  - `compiler.exe`: Compiled executable

## Prerequisites
- Flex (Lex)
- Bison (Yacc)
- GCC (or any C compiler)

## Building the Project
1. Generate the lexer:
   ```
   flex lexer.l
   ```
2. Generate the parser:
   ```
   bison -d parser.y
   ```
3. Compile the code:
   ```
   gcc lex.yy.c parser.tab.c -o compiler
   ```

## Running the Compiler
Run the compiled executable with input from a file:
```
./compiler < input.txt
```
Replace `input.txt` with your test file.

## Example
See `test.c` for an example of input code that can be parsed.

## License
This project is for educational purposes. Feel free to use and modify.

## Author
[Your Name]

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.