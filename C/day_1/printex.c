#include <stdio.h>
#include <stdlib.h> // Preprocessor dirs on separate lines
int main(void)
// vim hello.c
{
    /* This is the main function.
       Program execution begins here.
     
    * This is a multi-line comment
      This is the second line of a multi-line comment */

    printf("Hello, world!\n"); // This is for reporting to user
    printf("This is an interger: %i. \nThis is another integer: %i \n", 234, 12);
    // notice the . in the end

    return 0; // This returns codes to the OS;
}

