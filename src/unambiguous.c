#include <stdio.h>


int main()
{
    int c;

    while ((c = getchar()) != EOF) {
        if (c == '\t')
            fputs("\\t", stdout);
        else if (c == '\b')
            fputs("\\b", stdout);
        else if (c == '\\')
            fputs("\\\\", stdout);
        else
            putchar(c);
    }


    return 0;
}
