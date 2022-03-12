#' Compute expected hitting times until reaching a state
#'
#' @param P original probability transition matrix
#' @param states the set of states to hit
#'
#' @description {Solve the linear system resulting from
#' first step analysis until time of absorption.}
#' @return vector/matrix
#' @export dtmc_hitting_times
dtmc_hitting_times <- function(P, states)
{
  n <- nrow(P)
  m <- length(states)
  if(n-m == 1)
  {
    stop("Too many absorbing states, try fewer.")
  }
  A <- P
  #A[states, ] <- 0
  #A[states, states] <- 1
  A <- A[-states, -states]
  I <- diag(n-m)
  b <- rep(1, n-m)
  k <- solve(I-A, b)
  k <- as.matrix(k)
  # Label with the appropriate starting states
  starts <- setdiff(1:n, states)
  rownames(k) <- starts
  return(k)
}


#' Compute expected hitting chance of reaching a state
#'
#' @param P original probability transition matrix
#' @param states the set of states to hit
#' @param before boolean to compute hitting probability of \code{states[1]} before
#' \code{states[2]}.
#'
#' @description {Solve the linear system resulting from
#' first step analysis until time of absorption.}
#' @return vector/matrix
#' @export dtmc_hitting_chances
dtmc_hitting_chances <- function(P, states, before = FALSE)
{
  n <- nrow(P)
  m <- length(states)
  if(n-m == 1)
  {
    stop("Too many absorbing states, try fewer.")
  }
  A <- P
  # A[states, ] <- 0
  # A[states, states] <- 1

  b <- A[, states]
  if(before)
  {
    b[, 1] <- 0
  }

  if(!is.null(ncol(b)))
  {
    b <- b[-states, ]
    b <- apply(b, 1, sum)
  } else{
    b <- b[-states]
  }

  A <- A[-states, -states]
  I <- diag(n-m)
  k <- solve(I-A, b)
  k <- as.matrix(k)
  # Label with the appropriate starting states
  starts <- setdiff(1:n, states)
  rownames(k) <- starts
  return(k)

}



#' Compute expected hitting times until reaching a state
#'
#' @param Q original probability transition matrix
#' @param states the set of states to hit
#'
#' @description {Solve the linear system resulting from
#' first step analysis until time of absorption.}
#' @return vector/matrix
#' @export ctmc_hitting_times
ctmc_hitting_times <- function(Q, states)
{
  P <- jump_chain(Q)
  n <- nrow(P)
  m <- length(states)
  if(n-m == 1)
  {
    stop("Too many absorbing states, try fewer.")
  }
  A <- P
  # A[states, ] <- 0
  # A[states, states] <- 1
  A <- A[-states, -states]
  I <- diag(n-m)
  b <- -1/diag(Q[-states, -states])
  k <- solve(I-A, b)
  k <- as.matrix(k)
  # Label with the appropriate starting states
  starts <- setdiff(1:n, states)
  rownames(k) <- starts
  return(k)
}

#' Compute expected hitting chance of reaching a state
#'
#' @param Q original probability transition matrix
#' @param states the set of states to hit
#' @param before boolean to compute hitting probability of \code{states[1]} before
#' \code{states[2]}.
#'
#' @description {Solve the linear system resulting from
#' first step analysis until time of absorption.}
#' @return vector/matrix
#' @export ctmc_hitting_chances
ctmc_hitting_chances <- function(Q, states, before = FALSE)
{
  P <- jump_chain(Q)
  n <- nrow(P)
  m <- length(states)
  if(n-m == 1)
  {
    stop("Too many absorbing states, try fewer.")
  }
  A <- P
  # A[states, ] <- 0
  # A[states, states] <- 1

  b <- A[, states]
  if(before)
  {
    b[, 1] <- 0
  }

  if(!is.null(ncol(b)))
  {
    b <- b[-states, ]
    b <- apply(b, 1, sum)
  } else{
    b <- b[-states]
  }

  A <- A[-states, -states]
  I <- diag(n-m)
  k <- solve(I-A, b)
  k <- as.matrix(k)
  # Label with the appropriate starting states
  starts <- setdiff(1:n, states)
  rownames(k) <- starts
  return(k)

}
