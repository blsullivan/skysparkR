
##function converts a character to its index position in base64
FromBase64 <- function(character){
  base64 <- unlist(strsplit("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", ""))
  which(base64 ==  character) - 1
}

## function takes a "periods" string from skyspark sparks() result and converts it to a data frame of all times
## returns in the form of a data frame with starting time in col1, duration in col2
## all times are in minutes starting at midnight = 00:00
DecodePeriod <- function(periodString){
  characters <- unlist(strsplit(periodString, ""))
  characters <- as.numeric(sapply(characters, FromBase64))
  
  results <- data.frame(startTime = integer(), duration = integer())
  i <- 1
    
  while (i < length(characters)){
    time <- bitwShiftL(characters[i], 6) + characters[i + 1]
    duration <- bitwShiftL(characters[i + 2], 6) + characters[i + 3]
    
    results[(i-1)/4 + 1,] <- c(time, duration)
    
    i <- i + 4
  }

  return(results)
}

