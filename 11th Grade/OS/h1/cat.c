//--------------------------------------------
// NAME: Mihail Zdravkov
// CLASS: XIb
// NUMBER: 22
// PROBLEM: #1
// FILE NAME: cat.c
// FILE PURPOSE: Contains the main function of the cat function. 
//---------------------------------------------

#include <stdio.h>
#include <string.h>

//--------------------------------------------
// FUNCTION: main(int argc, char** argv) 
// Main function to run the cat function.
// PARAMETERS:
// int argc: The count of argv.
// char** argv: The argument list.
//----------------------------------------------

int main(int argc, char** argv)
{
	if (check_argv(argc, argv)) // if there is unappropriate argument we return 1
		return 1;

	if (argc == 1) // if cat receive no arguments
		read_and_print();

	int i;
	for (i = 1; i < argc; i++) // for every argument
	{
		if (strcmp(argv[i], "-") == 0) // if the arg is '-'
			read_and_print();
		else
			print_file(argv[i]);
	}

	return 0;
}
