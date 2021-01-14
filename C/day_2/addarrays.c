#include <stdio.h>

int main(void)
{
    int myarray1[] = {1,2,3,4};
    int myarray2[] = {2,2,2};
    int result[7];

    // concatenation:
    int i=0;
    for ( i = 0; i < 7; ++i)
    {
        if (i < 4)
        {
            result[i] = myarray1[i];
        } else
        {
            result[i] = myarray2[i-4];
        }
    }
    
    for ( i = 0; i < 7; ++i)
    {
        printf("%i\n", result[i]);
    }
    
    // Summing:
    for ( i = 0; i < 3; i++)
    {
        myarray1[i] = myarray1[i] + myarray2[i];
        // or
        myarray1[i] += myarray2[i];

    }
    
    printf("summed arrays:\n");
    for ( i = 0; i < 5; i++)
    {
        printf("%i\n", myarray1[i]);
    }
    

    return 0;
}