//--------------------------------------------
// NAME: Mihail Zdravkov
// CLASS: XIb
// NUMBER: 22
// PROBLEM: #1
// FILE NAME: catlib.h
// FILE PURPOSE: Contains the declaration of the functions needed for implementing basic cat function.
//---------------------------------------------


//--------------------------------------------
// FUNCTION: check_file(char*) 
// Checks whether a file can be used by cat. 
// (dirs, files with no permission to this user and etc. will return 1.
// PARAMETERS:
// char* file_path: Here you should pass the path to the file, you want to check.
//----------------------------------------------

extern int check_file(char*);

//--------------------------------------------
// FUNCTION: check_argv(int, char**) 
// Checks the given argv whether the arguments are OK to be used by cat. It uses check_file(char**)
// PARAMETERS:
// int argc: The count of argv
// char** argv: Your argument list.
//----------------------------------------------

extern int check_argv(int, char**);

//--------------------------------------------
// FUNCTION: read_and_print()
// Reads and prints what have been written to stdin. 
// PARAMETERS: NONE
//----------------------------------------------

extern void read_and_print(void);

//--------------------------------------------
// FUNCTION: print_file(char**) 
// Prints file to stdout.
// PARAMETERS: 
// char** file_path: Here you should pass the path to the file, you want to print.
//----------------------------------------------

extern void print_file(char*);
