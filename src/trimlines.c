#include <stdio.h>
#include "get_line.h"


#define MAXLINE 120


size_t trim_line(char line[], size_t len)
{
    while (line[--len] == ' ' || line[len] == '\t' || line[len] == '\n') {
        if (len == 0) {
            return 0;
        } else {
            line[len] = '\0';
        }
    }

    line[++len] = '\n';

    return len;
}


int main()
{
    size_t len;
    char line[MAXLINE];

    while ((len = get_line(line, MAXLINE)) > 0)
        if (trim_line(line, len) > 0)
            fputs(line, stdout);

    return 0;
}
