/*!
  @file
  @brief Longest Line
  @author Eric Bailey
  @date 2019-04-13
*/
#include <stdio.h>
#include "get_line.h"

/// The maximum line length to read into memory.
#define MAXLINE 80


void copy(char to[], char from[]);


int main()
{
    int len, max;
    char line[MAXLINE], longest[MAXLINE];

    max = 0;
    while ((len = get_line(line, MAXLINE)) > 0)
        if (len > max) {
            max = len;
            copy(longest, line);
        }

    if (max > 0) {
        printf("The longest line had %d characters:\n%s", max, longest);
        if (max >= MAXLINE && longest[MAXLINE - 1] != '\n')
            fputs("...\n", stdout);
    }

    return 0;
}


/* copy: copy `from' into `to'; assume `to' is big enough */
void copy(char to[], char from[])
{
    int i;
    i = 0;
    while ((to[i] = from[i]) != '\0')
        ++i;
}
