makeCacheMatrix <- function(x) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) m <<- solve
  getsolve <- function() m
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}

# m <- rbind(c(1, -1/4), c(-1/4, 1))

# > m2 <- makeCacheMatrix(m)
# > cacheSolve(m2)
# [,1]      [,2]
# [1,] 1.0666667 0.2666667
# [2,] 0.2666667 1.0666667

# > m2$get()
# [,1]  [,2]
# [1,]  1.00 -0.25
# [2,] -0.25  1.00

# > m2$getsolve()
# [,1]      [,2]
# [1,] 1.0666667 0.2666667
# [2,] 0.2666667 1.0666667

# > m2$set(rbind(c(-1/4, 1), c(1, -1/4)))
# > m2$getsolve()
# NULL

# > cacheSolve(m2)
# [,1]      [,2]
# [1,] 0.2666667 1.0666667
# [2,] 1.0666667 0.2666667
# > cacheSolve(m2)
# getting cached data
# [,1]      [,2]
# [1,] 0.2666667 1.0666667
# [2,] 1.0666667 0.2666667