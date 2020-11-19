
import sys
import cProfile
import pstats
from io import StringIO

import LV1 # if I want to import a function from the other directory, this way does't work, what should I do if I want to do that?
import LV2




def main():
    # Create profiler (Just need to profile once)
    pr = cProfile.Profile()




    ## LV1

    # For each LV script...
    # Enable profiler
    pr.enable()
    # Run the script
    LV1.main([])
    
    # Disable profiler
    pr.disable()

    # Make a string buffer to put stuff in
    s = StringIO()

    # Extract the profile statistics (and put into s)
    ps = pstats.Stats(pr, stream=s)
    
    # For print_stats, the number in brackets is the proportion of results to return
    # (from 0.0 to 1.0, so 0.1 would be 10% of the results) 
    ps.print_stats(0).sort_stats('time')

    # Get the report and print to terminal
    print(s.getvalue())




    ## LV2

    pr.enable()
    LV2.main([0, 1., 0.1, 1.5, 0.75])
    pr.disable()
    s = StringIO()
    ps = pstats.Stats(pr, stream=s)
    ps.print_stats(0).sort_stats('time')
    print(s.getvalue())




if __name__ == '__main__':
    main()




