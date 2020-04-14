#' Estimate the transition-rate matrix of an observed CTMC
#'
#' @param chain the observed chain
#' @param times the times the chain is observed at
#' @param m the maximum of number of states in the chain
#'
#' @description {The scheme depends on number of transitions form a fixed state to any other state... more details to come.}
#' @return matrix
#' @export estimate_ctmc
estimate_ctmc <- function (chain, times, m)
{
  N_ij <- table(paste0(utils::head(chain, -1), utils::tail(chain,
                                                           -1)))
  R_i <- rowsum(c(diff(times), 0), group = chain)
  transitions <- rownames(N_ij)
  iD <- as.numeric(substr(transitions, 1, 1))
  jD <- as.numeric(substr(transitions, 2, 2))
  q_ij <- N_ij/R_i[iD]
  q_ii <- matrix(0, nrow = m)
  Qhat <- matrix(0, nrow = m, ncol = m)
  for (i in 1:m) {
    q_ii[i] <- -sum(q_ij[which(iD == i)])
  }
  for (i in 1:length(iD)) {
    Qhat[iD[i], jD[i]] <- q_ij[i]
  }
  diag(Qhat) <- q_ii
  return(Qhat)
}
