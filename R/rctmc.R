#' Simulate a continuous time Markov chain
#'
#' @param tt how long to simulate the chain for
#' @param Q the transition rate matrix also called the infinitesimal generator matrix
#' @param mu the initial distribution vector
#' @param states optional list of states for non-integer chains
#'
#' @description {The standard scheme to simulate CTMCs, e.g. in J.R. Norris's textbook.}
#' @return data.frame
#' @export rctmc
rctmc <- function (tt, Q, mu, states = NULL)
{
  q_i <- -diag(Q)
  P <- jump_chain(Q)
  chain <- list()
  jumpTs <- list()
  chain[[1]] <- initial_state(mu)
  jumpTs[[1]] <- 0
  i <- 2
  while (jumpTs[[i - 1]] < tt) {
    nextRate <- q_i[chain[[i - 1]]]
    if (nextRate > 0) {
      jumpTs[[i]] <- stats::rexp(1, rate = nextRate) +
        jumpTs[[i - 1]]
    }
    else if (nextRate == 0) {
      jumpTs[[i]] <- tt
    }
    chain[[i]] <- next_state(chain[[i - 1]], P)
    i <- i + 1
  }
  if (is.null(states)) {
    return(data.frame(time = unlist(jumpTs), state = unlist(chain)))
  }
  else {
    return(data.frame(time = unlist(jumpTs), state = states[unlist(chain)]))
  }
}
