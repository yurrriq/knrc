#include <stdio.h>
#include <string.h>
#define LOWER 0
#define UPPER 300
#define STEP  20

void hrule(size_t width)
{

}

void print_header(char lhs[], char rhs[])
{
    printf("| %s | %s |\n", lhs, rhs);
    putchar('|');
    for (size_t i = 0; i < strlen(lhs) + 2; ++i)
        putchar('-');
    putchar('+');
    for (size_t i = 0; i < strlen(rhs) + 2; ++i)
        putchar('-');
    puts("|");
}

#define cels2fahr(cels) ((9.0/5.0)*cels+32.0)
void celsfahr()
{
    print_header("Celsius", "Fahrenheit");
    for (int celsius = LOWER; celsius <= UPPER; celsius += STEP)
        printf("| %7d | %10.0f |\n", celsius, cels2fahr(celsius));
}

#define fahr2cels(fahr) ((fahr-32.0)*(5.0/9.0))
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
