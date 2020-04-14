#' Convert between transition-rate matrix to the associated jump-chain's transition-probability matrix for a CTCM
#'
#' @param Q the transition-rate matrix given for the CTCM
#'
#' @description {Every CTMC has an embedded DTMC associated with it called the jump-chain. This function computes that jump
#' -chain's transition-probability matrix.}
#' @return matrix
#' @export jump_chain
jump_chain <- function (Q)
{
  q_i <- -diag(Q)
  m <- length(q_i)
  jumpChainMatrix <- matrix(0, nrow = m, ncol = m)
  for (i in 1:m) {
    for (j in 1:m) {
      if (i == j) {
        if (q_i[i] != 0) {
          jumpChainMatrix[i, j] <- 0
        }
        else if (q_i[i] == 0) {
          jumpChainMatrix[i, j] <- 1
        }
      }
      else {
        if (q_i[i] != 0) {
          jumpChainMatrix[i, j] <- Q[i, j]/q_i[i]
        }
        else if (q_i[i] == 0) {
          jumpChainMatrix[i, j] <- 0
        }
      }
    }
  }
  return(jumpChainMatrix)
}
