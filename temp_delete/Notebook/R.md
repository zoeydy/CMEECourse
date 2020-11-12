## Install:
```sudo apt install r-base-dev```
## Open
terminal + R + enter

## tips
c() - concatenate ?c

is.*() family : na-not avaliable; nan-not a number; inf-infinity; NULL-variable not set

as.*() family: R maps all values other than 0 to logical TRUE, and 0 to FALSE.

E notation: 1/***1***e3


# variable types
```clase(variable)```

## matrix
mat1 <- matrix(1:25, 5, 5) 

mat1 <- matrix(1:25, 5, 5, byrow = TRUE)

arr <- array(1:50 c(5, 5, 2))

## array
*just like R vector, R metrix and R arrays have to be of a homogeneous type.

## frames
1. build a frame  
```frame = <- data.frame(column1, column2, column3)```

2. give every column a name  
```names(frame) <- ("firstcolumn", "secondcolumn", "thirdcolumn")```

3. extract a specific column using '$'/'[]'  
```frame$column_names```   
```frame[1]```  
   ```frame[,1]```   
   ```frame[1,1]```   
   ```frame[c('firstcolumn', 'second column')]```

*do not use spaces in column names. But using dots in column names is OK, just as it is for variable names.*