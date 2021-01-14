#include <stdio.h>

int main(void)
{
    int x;
    long int longx;
    char c;

    x = 258;
    c = 'a';
    c = x;
    printf("x is: %i\n", x);
    printf("c is: %c\n", c);

    
    x = 258;
    c = 'a';
    c = x;
    x = c;
    printf("x is: %i\n", x);
    printf("c is: %c\n", c);

    return 0;
}