#include <stdio.h>

char mychar = "c";


int main(void)

{
    // integral(i.e. like intergers or are intergers)
    int x=11; //a place in memory for an integer
    char c; // a character

    /*
    * 0001:1
    * 0010:2
    * 0011:3
    * 
    */

    // floating-point type (i.e. 1.0019299)
    float flt; // a floating point number
    double dbl; // a double-precision float

    // x = 12345678909876543234567898765432123456789876543;
    //flt = 3;
    flt = 3.1;
    //flt = 2.3456789876543;

    char another_charactor;
    char _another_charactor1; // leading numbers diaslloweds

    printf("The value in x is: %i.\n", x);
    printf("The value in flt is: %f.\n", flt);
    printf("The value in flt is: %.25f.\n", flt);
    printf("The value in char is: %c.\n", char);

    return 0;
}