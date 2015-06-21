makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}

# c <- c(1,2,3,4)

# c2 <- makeVector(c)
# cachemean(c2)
# [1] 2.5

# c2$get()
# [1] 1 2 3 4

# c2$getmean()
# [1] 2.5
# c2$getmean()
#[1] 2.5
# c2$set(c(5,6))
# c2$getmean()
# NULL
# cachemean(c2)
# [1] 5.5
# cachemean(c2)
# getting cached data
# [1] 5.5

# c3 <- c(7,8)
# c4 <- makeVector(c3)
# cachemean(c4)
# [1] 7.5

# cachemean(c2)
# getting cached data
# [1] 2.5

