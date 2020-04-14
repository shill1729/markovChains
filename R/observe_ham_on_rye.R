#' Convert the raw text of all of Ham on Rye to observed Markov chain of words
#'
#' @param punctuation boolean whether to keep punctuation (TRUE) or not (FALSE)
#' @param uppercase boolean whether to distinuqish between uppercase (TRUE) or not (FALSE)
#' @param reducedSize this text is huge, so using only portions of it makes the DTMC estimation go faster.
#'
#' @description {Formatting of the raw text file of Ham on Rye. The function prepares it into a discrete time observed
#' chain by putting each word in a big vector/list, removing punctuation, cases, and titles.}
#' @return list containing named entries
#' @export observe_ham_on_rye
observe_ham_on_rye <- function(punctuation = FALSE, uppercase = FALSE, reducedSize = 10000)
{
  # utils::data("sonnets")
  dat <- markovChains::hamOnRye
  wordChain <- unlist(strsplit(as.character(dat), split = " "))
  # Remove newlines
  wordChain <- gsub("[\n]", "", wordChain)
  # Optionally remove punctuation and uppercase
  if(!punctuation)
  {
    wordChain <- gsub("[[:punct:]]", "", wordChain)
  }
  if(!uppercase)
  {
    wordChain <- tolower(wordChain)
  }


  print(paste("Actual length", length(wordChain)))
  if(!is.null(reducedSize))
  {
    print(paste("Using reduced size of", reducedSize, "words"))
    wordChain <- wordChain[1:reducedSize]
  }
  M <- length(wordChain)
  # Remove duplicates to get unique state space. Use a random ordering so as to not give any specific meaning.
  stateSpace <- unique(wordChain[sample(1:M, M)])
  N <- length(stateSpace)
  # Translate the word chain into indexes of the state space
  encodedChain <- apply(as.matrix(1:M), 1, function(j){which(stateSpace == wordChain[j])})
  print("Encoded chain")
  print(utils::head(stateSpace[encodedChain]))
  print("Word chain")
  print(utils::head(wordChain))
  print(cbind(number_of_words = N, length_of_chain = M))
  output <- list(wordChain = wordChain, encodedChain = encodedChain, stateSpace = stateSpace)
  return(output)
}
