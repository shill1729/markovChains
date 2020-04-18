#' Numerically compute the transition matrix of a CTMC given the generator matrix
#'
#' @param t time input
#' @param Q generator matrix, also called Q-matrix, and transition-rate matrix.
#'
#' @description {Computes \eqn{P(t)=e^{tQ}}, numerically}
#' @details {The exponential of a matrix is defined by the Taylor series \eqn{\sum (tQ)^n/n!}}
#' @return matrix
#' @export semigroup
semigroup <- function(t, Q)
{
  P <- Matrix::expm(t*Q)
  P <- as.matrix(P)
  return(P)
}
