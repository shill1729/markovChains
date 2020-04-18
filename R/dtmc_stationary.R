#' Compute the stationary distribution of a DTMC given a transition-probability matrix
#'
#' @param P the transition-probability matrix for the given DTMC
#'
#' @description {Uses the basic linear-algebra constrained method to solve for the limiting distribution, if it exists.}
#' @return vector
#' @export dtmc_stationary
dtmc_stationary <- function (P)
{
  m <- dim(P)[1]
  b <- c(rep(0, m), 1)
  I <- matrix(0, nrow = m, ncol = m)
  diag(I) <- 1
  A <- rbind(I - P, rep(1, m))
  rank.A <- as.numeric(Matrix::rankMatrix(A))
  rank.Ab <- as.numeric(Matrix::rankMatrix(cbind(A, b)))
  if (rank.A != rank.Ab) {
    stop("b in Ax=b not in column space of A")
  } else {
    return(drop(solve(t(A) %*% A, t(A) %*% b)))
  }
}
