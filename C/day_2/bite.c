#include <stdio.h>
#include <stdbool.h>

int main(void)
{

    bool site1[] = {true, true, true, false, true};
    bool site2[] = {false, true,true, false, true};
    bool siteol[5];

    unsigned char site1pk;
    unsigned char site2pk;

    int i = 0;
    for ( i = 0; i < 5; i++)
    {
        if (site1[i] == true && site2[i] == true)
        {
            siteol[i] = true;
            bool overlap = true;
        } else
        {
            siteol[i] = false;
        }
        
        
    }

    // site1pk & sitepk
    // would accomplish the same in bitwise operations
    // site1:11101 or can do: 10111
    // site2:01101 or can do: 10110

    for ( i = 0; i < 5; i++)
    {
        if (site1[i])
        {  
           site1pk = site1pk | (1 << i);
           site1pk |= (1<<i);
        }
    }
    
    printf("Numetical value of sitepk1: %i\n", (int)site1pk);

    return 0;

}