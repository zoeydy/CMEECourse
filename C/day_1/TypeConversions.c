#include <stdio.h>

int main(void)
{
    int i1 = 2;
    int i2 = 7;
    int result_int;
    float result_float;

    printf("assign mixed to int: %i\n", result_int = i2/i1);
    printf("assign mixed to float: %f\n", result_float = i2/i1);
    printf("assign mixed with const to float: %f\n", result_float = i2/2);

    return 0;

}