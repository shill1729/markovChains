#' Convert the raw text of all 154 sonnets to an observed Markov chain of words
#'
#' @param punctuation boolean whether to keep punctuation (TRUE) or not (FALSE)
#' @param uppercase boolean whether to distinuqish between uppercase (TRUE) or not (FALSE)
#'
#' @description {Formatting of the raw text file of 154 sonnets by Shakespeare. The function prepares it into a discrete time observed
#' chain by putting each word in a big vector/list, removing punctuation, cases, and titles.}
#' @return list containing named entries
#' @export observe_sonnet_chain
observe_sonnet_chain <- function(punctuation = FALSE, uppercase = FALSE)
{
  # utils::data("sonnets")
  dat <- markovChains::sonnets
  n <- dim(dat)[1]
  # The titles are every 15 lines but there seems to be an odd one out
  early_titles <- which((1:n)%%15==0)
  later_titles <- which((n:1)%%15==0)
  titles <- c(early_titles[1:98], later_titles[100:153])
  romanNums <- dat[titles,]
  # Remove the titles and convert to word by word database.
  dat <- dat[-titles,]
  wordChain <- unlist(strsplit(as.character(dat), split = " "))
  # Optionally remove punctuation and uppercase
  if(!punctuation){
    wordChain <- gsub("[[:punct:]]", "", wordChain)
  }
  if(!uppercase)
  {
    wordChain <- tolower(wordChain)
  }
  # wordChain <- wordChain[1:5000]
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

