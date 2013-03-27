//--------------------------------------------
// NAME: Mihail Zdravkov
// CLASS: XIb
// NUMBER: 22
// PROBLEM: #2
// FILE NAME: cat.c
// FILE PURPOSE: Contains the main function of the cat function.
//---------------------------------------------

#include <stdio.h>
#include <string.h>
#include <ctype.h>

//--------------------------------------------
// FUNCTION: main(int argc, char** argv)
// Main function to run the cat function.
// PARAMETERS:
// int argc: The count of argv.
// char** argv: The argument list.
//----------------------------------------------

int main(int argc, char** argv)
{
	int opt = 0;
	if (check_argv(argc, argv, &opt)) // if there is unappropriate argument we return 1
		return 1;

	if (argc == 1) // if wc receive no arguments
	{
		read_and_print_info();
		printf("\n");
	}

	int i;
	for (i = 1; i < argc; i++) // for every argument
	{
		if (argv[i][0] != '-')
		{
			print_wc(get_lines_c(argv[i]), get_words_c(argv[i]), get_bytes_c(argv[i]), opt);
			printf("\t%s\n", argv[i]);
		}
		else if (strlen(argv[i]) == 1) // is -
		{
			read_and_print_info();
			printf("\t%s\n", argv[i]);
		}
	}

	return 0;
}
