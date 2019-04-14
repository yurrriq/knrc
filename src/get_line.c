/**
 * @file
 */

#include <stdio.h>
#include "get_line.h"



/**
 * Read a line into @p s, up to @p lim characters.
 *
 * @param s A character array.
 * @param lim The length of @p s.
 *
 * @return The full length of the line.
 */
int get_line(char s[], int lim)
{
    int c = EOF, i;

    for (i = 0; i < lim - 1 && (c = getchar()) != EOF; ++i) {
        s[i] = c;
        if (c == '\n') {
            ++i;
            break;
        }
    }

    s[i] = '\0';

    if (c == '\n')
        return i;

    while ((c = getchar()) != EOF) {
        ++i;
        if (c == '\n')
            break;
    }

    return i;
}
