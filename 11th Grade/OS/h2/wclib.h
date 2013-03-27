//--------------------------------------------
// NAME: Mihail Zdravkov
// CLASS: XIb
// NUMBER: 22
// PROBLEM: #2
// FILE NAME: wclib.h
// FILE PURPOSE: Contains the declaration of the functions needed for implementing basic wc function.
//---------------------------------------------


//--------------------------------------------
// FUNCTION: check_file(char*)
// Checks whether a file can be used by wc.
// (dirs, files with no permission to this user and etc. will return 1.
// PARAMETERS:
// char* file_path: Here you should pass the path to the file, you want to check.
//----------------------------------------------

extern int check_file(char*);

//--------------------------------------------
// FUNCTION: check_argv(int, char**)
// Checks the given argv whether the arguments are OK to be used by wc. It uses check_file(char**)
// PARAMETERS:
// int argc: The count of argv
// char** argv: Your argument list.
// int* opt: Modifies the given int, by the options in argv.
//----------------------------------------------

extern int check_argv(int, char**, int*);

//--------------------------------------------
// FUNCTION: get_words_c(char*)
// Returns the word count of a given file.
// PARAMETERS:
// char* file_path: the path to the file.
//----------------------------------------------

extern int get_words_c(char*);

//--------------------------------------------
// FUNCTION: get_lines_c(char*)
// Returns the lines count of a given file.
// PARAMETERS:
// char* file_path: the path to the file.
//----------------------------------------------

extern int get_lines_c(char*);

//--------------------------------------------
// FUNCTION: get_bytes_c(char*)
// Returns the bytes count of a given file.
// PARAMETERS:
// char* file_path: the path to the file.
//----------------------------------------------

extern int get_bytes_c(char*);

//--------------------------------------------
// FUNCTION: print_wc(int, int, int, opt)
// Prints info, as options dictate.
// PARAMETERS:
// int line_c, word_c, bytes_c (where c = count) and options
//----------------------------------------------

extern void print_wc();

//--------------------------------------------
// FUNCTION: read_and_print_info()
// Reads from stdin and prints info.
// PARAMETERS: NONE
//----------------------------------------------

extern void read_and_print_info();
