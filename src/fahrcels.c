#include <stdio.h>
#include <string.h>
#define LOWER 0
#define UPPER 300
#define STEP  20
void print_header(char lhs[], char rhs[])
{
    printf("| %s | %s |\n", lhs, rhs);
    putchar('|');
    for (int i = -2; i < (int) strlen(lhs); ++i)
        putchar('-');
    putchar('+');
    for (int i = -2; i < (int) strlen(rhs); ++i)
        putchar('-');
    puts("|");
}

void celsfahr()
{
    print_header("Celsius", "Fahrenheit");
    for (int celsius = 0; celsius <= 300; celsius += 20)
        printf("| %7d | %10.0f |\n", celsius,
               32.0 + (9.0 / 5.0) * celsius);
}

void fahrcels()
{
    print_header("Fahrenheit", "Celsius");
    for (int fahr = UPPER; fahr >= LOWER; fahr -= STEP)
        printf("| %10d | %7.1f |\n", fahr, (5.0 / 9.0) * (fahr - 32.0));
}

int main()
{
    fahrcels();
    puts("\n");
    celsfahr();

    return 0;
}
