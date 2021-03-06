## There are two functions: one which stores a special matrix objects which is able to cache it's inverse
## matrix and one which actually computes the inverse *IF* it is not already in the cache

## This function creates a special matrix object which can cache it's reverse
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    get <- function() x
    # define R function "solve" for calculating inverse matrix:
    setinv <- function(solve) inv <<- solve
    getinv <- function() inv
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)
}


## This function calculates the inverse matrix if it's not already in the cache; in the latter
## case the inverse is simply read from the cache
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv <- x$getinv()
    # check if inverse matrix is in cache; if yes, return:
    if(!is.null(inv)) {
        message("getting cached data")
        return(inv)
    }
    # inverse matrix not in cache, so calculate it:
    data <- x$get()
    inv <- solve(data, ...)
    x$setinv(inv)
    inv
}
