#' Generate a first-order Markov chain Shakespearean sonnet
#'
#' @param sonnet_data the object returned from \code{observe_sonnet_chain()}, a list containing \code{wordChain}, \code{encodedChain}, and \code{stateSpace}
#' @param P the probability transition matrix, if not passed will be estimated from the \code{sonnet_data} dataset
#'
#' @description {The transition probability matrix is estimated from all 154 sonnets}
#' @return string/character
#' @export markov_sonnet
markov_sonnet <- function(sonnet_data, P = NULL)
{
  # Extract data
  wordChain <- sonnet_data$wordChain
  encodedChain <- sonnet_data$encodedChain
  stateSpace <- sonnet_data$stateSpace

  # Sonnet formatting
  wordsPerLine <- 10
  simLength <- 14*wordsPerLine

  # Estimate transition-probability matrix
  if(is.null(P))
  {
    P <- estimate_dtmc(chain = encodedChain, m = length(stateSpace))
  }

  # Simulate chain
  sim <- rdtmc(n = simLength, P = P, mu = c(0, 1, rep(0, length(stateSpace)-1)), states = stateSpace)
  sim <- sim$state

  # Format and paste/collapse output
  output <- matrix(data = sim, nrow = 14, ncol = wordsPerLine)
  output <- apply(output, 1, function(x){paste(x, collapse = " ")})
  return(output)
}
