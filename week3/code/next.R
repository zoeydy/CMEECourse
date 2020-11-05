rm(list = ls())

for (i in 1:10){
    if((i %% 2 ) == 0)
    
        next # pass to next iteration of loop
    print(i)
}

# pay attention to the positon of print order
# for (i in 1:10){
#     if((i %% 2 ) == 0)
#     print(i)
#         next # pass to next iteration of loop
    
# }