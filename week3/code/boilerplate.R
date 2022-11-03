# A boilplate R script

MyFunction <- function(Arg1, Arg2) {
  
  # Statements involving Arg1, Arg2:
  print(paste("Arguement", as.character(Arg1), "is a", class(Arg1))) # set the Arg1 and print Arg1's type
  print(paste("Arguement", as.character(Arg2), "is a", class(Arg2)))
  
  return(c(Arg1, Arg2))
}

MyFunction(1,2) # Test the function
MyFunction("Riki","Tiki") # Double check