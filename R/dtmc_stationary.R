#' Compute the stationary distribution of a DTMC given a transition-probability matrix
#'
#' @param P the transition-probability matrix for the given DTMC
#'
#' @description {Uses the basic linear-algebra constrained method to solve for the limiting distribution, if it exists.}
#' @return vector
#' @export dtmc_stationary
dtmc_stationary <- function (P)
{
  n <- nrow(P)
  I <- diag(nrow = n)
  W <- t(P)-I
  ones <- rep(1, n)
  A <- rbind(W, ones)
  b <- rep(0, n+1)
  b[n+1] <- 1
  pi <- qr.solve(A, b)
  return(pi)
}


#' Compute the stationary distribution of a CTMC given a transition-rate matrix
#'
#' @param Q the transition-rate matrix for the given CTMC
#'
#' @description {Uses the basic linear-algebra constrained method to solve for the limiting distribution, if it exists.}
#' @return vector
#' @export ctmc_steady_state
ctmc_steady_state <- function (Q)
{
  n <- nrow(Q)
  W <- t(Q)
  ones <- rep(1, n)
  A <- rbind(W, ones)
  b <- rep(0, n+1)
  b[n+1] <- 1
  pi <- qr.solve(A, b)
  return(pi)
}
