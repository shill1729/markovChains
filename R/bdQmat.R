#' Populate a transition rate matrix for a Birth-Death process given birth and death rates
#'
#' @param lambda birth rate
#' @param mu death rate
#' @param m maximum number of population i.e. carrying capacity or in other contexts maximum number of states
#'
#' @description {For convenience to populate transition rate matrices for common CTMC models.}
#' @return matrix
#' @export birth_death_Q
birth_death_Q <- function(lambda, mu, m)
{
  birthDeathTrans <- matrix(data = 0, nrow = m, ncol = m)
  birthDeathTrans[1, 1] <- -lambda
  birthDeathTrans[1, 2] <- lambda
  for (i in 2:(m - 1)) {
    birthDeathTrans[i, i + 1] <- lambda
    birthDeathTrans[i, i - 1] <- mu
    birthDeathTrans[i, i] <- -(mu + lambda)
  }
  birthDeathTrans[m, m - 1] <- mu
  birthDeathTrans[m, m] <- -mu
  return(birthDeathTrans)
}
