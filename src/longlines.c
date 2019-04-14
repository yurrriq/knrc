/*!
  @file
  @brief Print long lines.
  @author Eric Bailey
  @date 2019-04-13
*/
#include <stdio.h>
#include "get_line.h"


/// The maximum line length to read into memory.
#define MAXLINE 57


/// The minimum line length to be considered long.
#define MINLENGTH 54


int main()
{
    int len;
    char line[MAXLINE];

    while ((len = get_line(line, MAXLINE)) > 0) {
        if (len > MINLENGTH)
            printf("%s", line);
        if (len >= MAXLINE && line[MAXLINE - 1] != '\n')
            fputs("...\n", stdout);
    }

    return 0;
}
