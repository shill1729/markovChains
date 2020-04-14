#' Estimate the transition-probability matrix of an observed DTMC
#'
#' @param chain the observed chain
#' @param m the maximum of number of states in the chain
#'
#' @description {The scheme depends on number of transitions from a fixed state to any other state... more details to come.}
#' @return matrix
#' @export estimate_dtmc
estimate_dtmc <- function (chain, m)
{
  N_ij <- table(paste0(utils::head(chain, -1), utils::tail(chain,
                                                           -1)))
  N_ij <- matrix(N_ij, nrow = m, ncol = m, byrow = TRUE)
  N <- apply(N_ij, 1, sum)
  Phat <- N_ij/N
  return(Phat)
}
