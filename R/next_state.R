#' Simulate the next state given the current state of a DTMC
#'
#' @param i the current state
#' @param P the transition-probability matrix
#'
#' @description {Basic intervallic partition sampling of the measures.}
#' @return integer
#' @export next_state
next_state <- function (i, P)
{
  d <- dim(P)[1]
  intervals <- c(0, cumsum(P[i, ]))
  u <- stats::runif(1)
  for (j in 1:(d)) {
    if (u > intervals[j] && u <= intervals[j + 1]) {
      return(j)
    }
  }
}
