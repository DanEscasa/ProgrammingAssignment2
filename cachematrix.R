## Put comments here that give an overall description of what your
## functions do

## Create a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
     m   <- NULL
     set <- function(y) {
          x <<- y
          m <<- NULL
     }
     get    <- function() x
     setInv <- function(solve) m <<- solve
     getInv <- function() m
     ## return as a list the functions that do the hard work
     list(set = set, get = get,
          setInv = setInv,
          getInv = getInv)
}

## cacheSolve takes the inverse of the special "matrix" returned by
## `makeCacheMatrix` above. If the inverse has already been calculated
## (and the matrix has not changed), then `cacheSolve` will retrieve 
## the inverse from the cache

cacheSolve <- function(x, ...) {
     ## Return a matrix that is the inverse of 'x'
     ## First try the getInv() function from makeCacheMatrix
     m <- x$getInv()
     ## return result from makeCacheMatrix::getInv() if it exists
     if(!is.null(m)) {
          message("getting cached data")
          return(m)
     }
     ## otherwise, compute using the usual inverse function
     data <- x$get()
     m    <- solve(data, ...)
     ## then cache the result
     x$setInv(m)
     m
}

