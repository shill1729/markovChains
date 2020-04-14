#' Simulate the initial state given an initial measure/distribution
#'
#' @param mu the initial probability measure, a vector whose entries sum to unity
#'
#' @description {A basic sampling scheme based of uniform RVs and the given measure.}
#' @return integer which represents the state
#' @export initial_state
initial_state <- function (mu)
{
  d <- length(mu)
  intervals <- c(0, cumsum(mu))
  u <- stats::runif(1)
  for (i in 1:(d)) {
    if (u > intervals[i] && u <= intervals[i + 1]) {
      return(i)
    }
  }
}
