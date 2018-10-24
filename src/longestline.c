#include <stdio.h>


#define MAXLINE 3


int getline(char line[], int maxline);
void copy(char to[], char from[]);


int main()
{
    int len, max;
    char line[MAXLINE], longest[MAXLINE];

    max = 0;
    while ((len = getline(line, MAXLINE)) > 0)
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


/* getline: read a line into s, return length */
int getline(char s[], int lim)
{
    int c, i;

    for (i = 0; i < lim - 1 && (c = getchar()) != EOF && c != '\n'; ++i)
        s[i] = c;

    if (c == '\n') {
        s[i] = c;
        ++i;
    }

    s[i] = '\0';

    if (c == '\n')
        return i;


    while ((c = getchar()) != '\n' && c != EOF)
        ++i;

    if (c == '\n')
        ++i;


    return i;
}


/* copy: copy `from' into `to'; assume `to' is big enough */
void copy(char to[], char from[])
{
    int i;
    i = 0;
    while ((to[i] = from[i]) != '\0')
        ++i;
}
