#include <stdio.h>

int main(void)
{
    int a=7, b =2, c=0;

    c = a + 4;
    printf("The result of %i + 4 is: %i\n", a, c);
    
    c = a/b;
    printf("The result of %i/%i is: %i\n", a, b, c);

    // how about change the result into float
    float d;
    d = a/b;
    printf("the result of %i/%i is: %f\n", a, b, d);


    // arithmetic on charactor data type
    char p[] = "a";
    char q[] = "h";
    
    char case_offset = p-q;
    printf("the char arith result is: %d\n", case_offset);

    return 0;
}