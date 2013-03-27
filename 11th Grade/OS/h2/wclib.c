//--------------------------------------------
// NAME: Mihail Zdravkov
// CLASS: XIb
// NUMBER: 22
// PROBLEM: #2
// FILE NAME: wclib.c
// FILE PURPOSE: Contains the definition of the functions, used for implementing basic wc function.
//---------------------------------------------

#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>

#include "wclib.h"

enum {OPT_C = 4, OPT_W = 2, OPT_L = 1};

int check_file(char* file_path)
{
	struct stat file_stats;

	if (stat(file_path, &file_stats) < 0) // no such file error
	{
		printf("wc: %s: %s\n", file_path, strerror(errno)); // print the error to stdin
		return 1; // error
	}

	if (!S_ISREG(file_stats.st_mode)) // if file is dir or other non-regular file.
	{
		printf("wc: %s: File is directory or other non-regular file.\n", file_path);
		return 1; // error
	}

	FILE* file = fopen(file_path, "r"); // open the file for reading only
	if (!file) // then we have an error
	{
		printf("wc: %s: %s\n", file_path, strerror(errno));
		return 1; // error
	}

	fclose(file);
	return 0; // no errors
}

int check_argv(int argc, char** argv, int* opt)
{
	int i, j;

	for (i = 1; i < argc; i++) // first arg is the command itself
	{
		if (argv[i][0] == '-') // if option
		{
			for (j = 1; j < strlen(argv[i]); j++)
			{
				switch (argv[i][j])
				{
					case 'c': *opt |= OPT_C; break;
					case 'w': *opt |= OPT_W; break;
					case 'l': *opt |= OPT_L; break;
					case  0 : break; // (because 0 is NULL in ascii)
					default:
						printf("wc: invalid option -- '%c'\n", argv[i][1]);
						return 1;
				}
			}
			continue;
		}

		if (check_file(argv[i]))
			return 1; // if we have just one file with error, we return 1
	}

	if (!(*opt)) *opt = OPT_C | OPT_W | OPT_L; // if there is no option, we set all options

	return 0;
}

void print_wc(int lines_c, int words_c, int bytes_c, int opt)
{
	if (opt & OPT_L) printf("%d ", lines_c);
	if (opt & OPT_W) printf("%d ", words_c);
	if (opt & OPT_C) printf("%d ", bytes_c);
}

void read_and_print_info()
{
	char str[42];
	int l = 0, w = 0, c = 0;
	FILE* fp = fopen("temp.llama", "w");

	while (fgets(str, 42, stdin))
	{
		fputs(str, fp);
	}

	fclose(fp);
	print_wc(get_lines_c("temp.llama"), get_words_c("temp.llama"), get_bytes_c("temp.llama"), 7);
	remove("temp.llama");
}

int get_bytes_c(char* file_path)
{
	FILE* fp = fopen(file_path, "r");
	fseek(fp, 0, SEEK_END);
	int result = ftell(fp);
	fclose(fp);

	return result;
}

int get_lines_c(char* file_path)
{
	FILE* fp = fopen(file_path, "r");
	int lines_c = 0;
	char ch;

	do {
		ch = fgetc(fp);
		if (ch == '\n')
			lines_c++;
	} while (ch != EOF);

	fclose(fp);

	return lines_c;
}

int get_words_c(char* file_path)
{
	FILE* fp = fopen(file_path, "r");
	int words_c = 0, sp;
	char ch;

	while ((ch = fgetc(fp)) != EOF)
	{
		if (isspace(ch))
		{
			sp = 1;
		} else if (sp)
		{
				++words_c;
				sp = 0;
		}
	}

	fclose(fp);

	return words_c;
}
