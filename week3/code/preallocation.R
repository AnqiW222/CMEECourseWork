# for loop that resizes a vector repeatedly

NoPreallocFun <- function(x) {
  a <- vector() # empty vector
  for (i in 1:x) {
    a <- c(a, i) # concatenate
    print(a)
    print(object.size(a))
  }
}

system.time(NoPreallocFun(10))

# if you “pre-allocate” a vector that fits all the values, R doesn’t have to 
# re-allocate memory each iteration

PreallocFun <- function(x) {
  a <- rep(NA, x) # pre-allocated vector
  for (i in 1:x) {
    a[i] <- i # assign
    print(a)
    print(object.size(a))
  }
}

system.time(PreallocFun(10))
