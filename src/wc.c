#include <stdio.h>
#include <stdbool.h>
double char_count()
{
    double nc = 0;

    while (getchar() != EOF)
        ++nc;

    return nc;
}

int line_count()
{
    int c, nl = 0;
    while ((c = getchar()) != EOF)
        if (c == '\n')
            ++nl;

    return nl;
}

bool is_whitespace(int c)
{
    return (c == ' ' || c == '\n' || c == '\t');
}


double ws_count()
{
    double ns = 0;
    int c = 0;

    while ((c = getchar()) != EOF)
        if (is_whitespace(c))
            ++ns;

    return ns;
}

#define IN  1
#define OUT 0
int main()
{
    int c, nl, nw, nc, state;

    state = OUT;
    nl = nw = nc = 0;
    while ((c = getchar()) != EOF) {
        ++nc;
        if (c == '\n')
            ++nl;
        if (c == ' ' || c == '\n' || c == '\t')
            state = OUT;
        else if (state == OUT) {
            state = IN;
            ++nw;
        }
    }

    printf("%7d%8d%8d\n", nl, nw, nc);

    return 0;
}
