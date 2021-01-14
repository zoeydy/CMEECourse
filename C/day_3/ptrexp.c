#include <stdio.h>

int main(void)
{
    int a = 2;
    int b = 4;
    int c = 0;

    int *a_ptr = &a; // reminder: &a reads "the address of a"
    int *b_ptr = &b;
    int *c_ptr = &c;

    *c_ptr = *a_ptr + b_ptr;
    printf("c_ptr: %ls\n", c_ptr);
    printf("*c_ptr: %i\n", *c_ptr);
    printf("c: %i\n", c);
    printf("a: %i\n", a);
    printf("b: %i\n", b);

    *c_ptr = a_ptr + *b_ptr;
    printf("c_ptr: %ls\n", c_ptr);
    printf("*c_ptr: %i\n", *c_ptr);
    printf("c: %i\n", c);
    printf("a: %i\n", a);
    printf("b: %i\n", b);

    *c_ptr = *a_ptr + *b_ptr;
    printf("c_ptr: %ls\n", c_ptr);
    printf("*c_ptr: %i\n", *c_ptr);
    printf("c: %i\n", c);
    printf("a: %i\n", a);
    printf("b: %i\n", b);

    c = a_ptr + *b_ptr;
    printf("c_ptr: %ls\n", c_ptr);
    printf("*c_ptr: %i\n", *c_ptr);
    printf("c: %i\n", c);
    printf("a: %i\n", a);
    printf("b: %i\n", b);

    c_ptr = a_ptr + *b_ptr;
    printf("c_ptr: %ls\n", c_ptr);
    printf("*c_ptr: %i\n", *c_ptr);
    printf("c: %i\n", c);
    printf("a: %i\n", a);
    printf("b: %i\n", b);

    return 0;
}

