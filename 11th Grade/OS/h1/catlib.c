//--------------------------------------------
// NAME: Mihail Zdravkov
// CLASS: XIb
// NUMBER: 22
// PROBLEM: #1
// FILE NAME: catlib.c
// FILE PURPOSE: Contains the definition of the functions, used for implementing basic cat function.
//---------------------------------------------


#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>

#include "catlib.h"

int check_file(char* file_path)
{
	struct stat file_stats;
	
	if (stat(file_path, &file_stats) < 0) // no such file error
	{
		printf("cat: %s: %s\n", file_path, strerror(errno)); // print the error to stdin
		return 1; // error 
	}

	if (!S_ISREG(file_stats.st_mode)) // if file is dir or other non-regular file.
	{
		printf("cat: %s: File is directory or other non-regular file.\n", file_path);
		return 1; // error
	}
	
	int file = open(file_path, O_RDONLY); // open the file for reading only
	if (file < 0) // then we have an error
	{
		printf("cat %s: %s\n", file_path, strerror(errno));
		return 1; // error
	}

	close(file);
	return 0; // no errors
}

int check_argv(int argc, char** argv)
{
	int i, error = 0; // def error with value 0
	
	for (i = 1; i < argc; i++) // from arg 1 (first passed argument)
	{
		if (strcmp(argv[i], "-") == 0)
			continue;
		int code = check_file(argv[i]);
		if (code)
		{
			error = 1; // if we have just one file with error, we return 1
		}
	}
	
	return error;
}

void read_and_print(void)
{
	char buffer[42]; // 42 is The Answer
  int reader;
	
	//reading while there is something to read
	while ((reader = read(0, buffer, sizeof(buffer))) > 0) // 0 is the value of stdin file descriptor.
	{
		write(1, buffer, reader); // print to stdout. (1 is the file descriptor value of stdout)
	}
}

void print_file(char* file_path)
{
	char buffer[42]; // 42 is The Answer
	int reader;

	int file = open(file_path, O_RDONLY);

	while ((reader = read(file, buffer, sizeof(buffer))) > 0)
	{
		write(1, buffer, reader);
	}

	close(file);
}
