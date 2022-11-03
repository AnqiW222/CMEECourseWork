SomeOperation <- function(v) { # when the sum of v greater than 0, then return 
  # v*100, otherwise return itself
  if (sum(v) > 0) { #note that sum(v) is a single (scalar) value
    return (v * 100)
  } else { 
    return (v)
  }
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))