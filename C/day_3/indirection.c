#include <stdio.h>

int main(void)
{
    // initialize the ptr
    int a = 3;
    int *ptr = &a;
    int i = 1;
    printf("ptr: %ls\n", ptr);
    printf("*ptr: %i\n", *ptr);
    printf("i: %i\n", i);
    printf("i: %i\n", a);

    ptr = &i;
    printf("ptr: %ls\n", ptr);
    printf("*ptr: %i\n", *ptr);
    printf("i:%i\n", i);
    printf("i:%i\n", a);

    ptr = &a;
    printf("ptr: %ls\n",ptr);
    printf("*ptr: %i\n",*ptr);
    printf("i:%i\n", i);
    printf("i:%i\n", a);

    // indirectlly assign the value to a
    *ptr = 7;
    printf("ptr: %ls\n", ptr);
    printf("*ptr: %i\n", *ptr);
    printf("i:%i\n", i);
    printf("i:%i\n", a);


    return 0;
}