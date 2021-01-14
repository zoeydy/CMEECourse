#include <stdio.h>

float fltdiv(const int x,const int y)
{
    float retval = 0.0;

    retval = (float)x/(float)y;

    return retval;
}

int main(void)
{
    int a = 7;
    int b = 3;

    float x = (float)a/b;
    
    x = fltdiv(a,b);

    printf("%i divided by %i is: %f\n", a, b, x);
    
    return 0;
}