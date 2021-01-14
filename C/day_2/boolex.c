#include <stdio.h>
#include <stdbool.h>

int main(void)
{
    _Bool b; //Definition of _Bool: storage for 1 or 0
    // reality: smallest addressable unit: byte(8 bits)

    bool c;// same _Bool

    b = 0;
    b = 1;

    printf("value in b: %i\n", b);

    b = 5;
    printf("value in b is: %i\n", b);

    b = 256;
    printf("value in b is: %i\n", b);

    c = true;
    c = false;

    bool site1[] = {true, true, true, false, true};
    bool site2[] = {false, true,true, false, true};

    return 0;

}