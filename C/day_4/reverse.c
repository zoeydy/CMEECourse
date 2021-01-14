#include <stdio.h>
#include <string.h>

int reverse_string(char str[])
{
    int i;
    int lim;
    int j = strlen(str)-1;
    char c;

    lim = j/2;

    for ( i = 0; i <= lim; i++)
    {
        c = str[j];
        str[j] = str[i];
        str[i] = c;
        --j;

    }
    
    printf("%s\n", str);
    return 0;

}

_Bool str_compare(const char* str1, const char* str2)
{
    
}