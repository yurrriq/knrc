#include <stdio.h>


#define MIN_ASCII 0
#define MAX_ASCII 0177


void prchar(int c)
{
    switch (c) {
    case ' ':
        printf("%11s", "<space>");
        break;
    case '\b':
        printf("%11s", "<backspace>");
        break;
    case '\n':
        printf("%11s", "<newline>");
        break;
    case '\t':
        printf("%11s", "<tab>");
        break;
    default:
        /* FIXME: why can't I return this? */
        /* return ((char[2]) { (char) c, '\0' }); */
        printf("%11c", c);
        break;
    }
}


int main()
{
    int c;
    int freq[MAX_ASCII + 1] = { 0 };

    while ((c = getchar()) != EOF)
        ++freq[c];

    for (int i = 0; i <= MAX_ASCII; ++i) {
        if (!freq[i])
            continue;

        prchar(i);
        fputs(": ", stdout);
        for (int j = 0; j < freq[i]; ++j)
            putchar('#');
        putchar('\n');
    }


    return 0;
}
