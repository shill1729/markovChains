#' Simulate a discrete time Markov chain
#'
#' @param n number of steps to simulate in the chain
#' @param P the probability transition matrix
#' @param mu the initial distribution vector
#' @param states optional states if simulating strings or non-integer chains
#'
#' @description {The basic Markov chain simulation scheme found in J.R. Norris' book.}
#' @return data.frame
#' @export rdtmc
rdtmc <- function (n, P, mu, states = NULL)
{
  chain <- matrix(data = 0, nrow = n)
  chain[1] <- initial_state(mu)
  if (n > 1) {
    for (i in 2:n) {
      chain[i] <- next_state(chain[i - 1], P)
    }
  }
  if (is.null(states)) {
    return(data.frame(time = 1:n, state = chain))
  }
  else {
    return(data.frame(time = 1:n, state = states[chain]))
  }
}
