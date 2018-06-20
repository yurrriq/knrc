#include <stdio.h>
#include <stdbool.h>


int main()
{
    int c;
    bool prev_blank = false;

    while ((c = getchar()) != EOF) {
        if (!(prev_blank && c == ' '))
            putchar(c);
        prev_blank = (c == ' ');
    }


    return 0;
}
