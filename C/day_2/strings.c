#include <stdio.h>
#include <string.h>

int main(void)
{
    /* char string1[] = {'a', ' ', 's', 't', 'r', '\0'};
    char string2[] = "a string"; //Formats to the above.

    printf("the string1's 2ed index is: %d\n", string1[2]);
    printf("the string1's 2ed index is: %c\n", string1[2]);
    printf("the string2 is: %s\n", string2);
    */


    char string1[50] = {'a', ' ', 's', 't', 'r', '\0'};
    char string2[50] = "a string"; //Formats to the above.    

    // function prototype;
    // size_t strlen(const char * str);
    // for out purposes, we understand htis to mean:
    // unsigned long int strlen(const char []);

    long len = 0;
    len = strlen(string1);

    printf("the length of string1 is: %li\n", len);

    return 0;
}