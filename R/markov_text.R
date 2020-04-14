#' Generate a first-order Markov chain Shakespearean sonnet
#'
#' @param text_data the object returned from \code{observe_text()}, a list containing \code{wordChain}, \code{encodedChain}, and \code{stateSpace}
#' @param P the probability transition matrix, if not passed will be estimated from the \code{sonnet_data} dataset
#' @param wordsPerLine the number of words per line
#' @param numLines the number of lines
#'
#' @description {The transition probability matrix is estimated from all 154 sonnets}
#' @return string/character
#' @export markov_text
markov_text <- function(text_data, P = NULL, wordsPerLine = 10, numLines = 14)
{
  # Extract data
  wordChain <- text_data$wordChain
  encodedChain <- text_data$encodedChain
  stateSpace <- text_data$stateSpace
  simLength <- numLines*wordsPerLine

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
