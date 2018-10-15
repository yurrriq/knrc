#include <stdio.h>


#define IN    1
#define OUT   0

#define MAX_WORD_LENGTH 10
#define TERM_WIDTH 80


int main()
{
    int c, state, wl;
    int length[MAX_WORD_LENGTH + 1];

    for (int i = 0; i <= MAX_WORD_LENGTH; ++i)
        length[i] = 0;

    state = OUT;
    wl = 0;
    while ((c = getchar()) != EOF) {
        if (c == ' ' || c == '\n' || c == '\t') {
            if (state == IN) {
                state = OUT;
                ++length[wl <= MAX_WORD_LENGTH ? wl - 1 : MAX_WORD_LENGTH];
            }
        } else {
            if (state == OUT) {
                state = IN;
                wl = 0;
            }
            ++wl;
        }
    }

    for (int j = 0; j <= MAX_WORD_LENGTH; ++j) {
        if (j == MAX_WORD_LENGTH)
            printf(">%d: ", MAX_WORD_LENGTH);
        else
            printf(" %2d: ", j + 1);

        for (int k = 0; k < length[j]; ++k)
            putchar('#');
        putchar('\n');
    }


    return 0;
}
