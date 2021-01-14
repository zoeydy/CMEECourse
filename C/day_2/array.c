# include <stdio.h>

int main(void)
{
    int x=0;
    int intarray[5]; // explicitly sized
    int intarray2[] = {1,2,3,4,5,6}; // implicitly sized array

    printf("intarray at index %i is: %i\n", 0, intarray[0]);
    printf("intarray at index %i is: %i\n", 1, intarray[1]);
    printf("intarray at index %i is: %i\n", 2, intarray[2]);
    printf("intarray at index %i is: %i\n", 3, intarray[3]);
    printf("intarray at index %i is: %i\n", 4, intarray[4]);

    for ( x = 0; x<6 ; ++x)
    {
        intarray[x] = 0;
    }
    
    printf("intarray at index %i is: %i\n", 0, intarray[0]);
    printf("intarray at index %i is: %i\n", 1, intarray[1]);
    printf("intarray at index %i is: %i\n", 2, intarray[2]);
    printf("intarray at index %i is: %i\n", 3, intarray[3]);
    printf("intarray at index %i is: %i\n", 4, intarray[4]);


    return 0;
}