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
  A[states, ] <- 0
  A[states, states] <- 1
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
