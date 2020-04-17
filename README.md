
# markovChains

<!-- badges: start -->
<!-- badges: end -->

Work in progress package for providing functions in R for simulations of Markov chains, estimation of probability transition matrices and transition rate matrices, and computation of stationary distributions (when they exist) for *both* discrete time and continuous time Markov chains.


## Features

- [x] Simulating both discrete and continuous time Markov chains
- [x] Estimating the transition matrices of discrete and continuous time chains
- [x] Computing the stationary distribution if it exists of DTMCs
- [X] Sample text generation
- [ ] Computing the stationary distribution if it exists of CTMCs
- [ ] Common transition matrix functions available for quickly populating matrices
- [ ] More to come...

## Table of contents
1. [Installation](#installation)

2. [Examples](#examples)

## Installation

You can install the github version of markovChains with:

``` r
devtools::install_github("shill1729/markovChains")
```

## Examples

### Simulating a birth-death process in continuous time.
The plan is to include functions for populating transition matrices for common models. Here is an example
simulating a birth-death process.
```r
library(markovChains)
# Birth rate, death rate, carrying capacity, time-horizon
lambda <- 0.5
mu <- 0.25
m <- 100
tt <- 100
# Initial distribution: P(X_0=1)=1, start with population of 1 at time zero with 100% chance.
im <- c(0, 1, rep(0, m-2))
# Transition-rate matrix
Q <- birth_death_Q(lambda, mu, m) # actually a RW with reflecting barriers transition rate matrix
Q[1,] <- rep(0, m) # Ensures extinction if we reach zero population, a true BD process transition-rate matrix
# Simulating the BD process
x <- rctmc(tt, Q, im, states = c(0:(m-1)))
# Plotting the process
plot(x, type = "s", main = "Birth and Death Process")
```

## Markov text generators

We provide some rough but amusing text generators devoid of punctuation and lower/uppercase distinctions. The first example is from using Shakespeare's 154 sonnets the second is Bukowski's Ham on Rye.

### Simulating a Shakespearean "Sonnet"

Okay this will not actually follow the rhyming scheme of a sonnet, but it will give off a mild Shakespearean effect by using his vocab and first-order word frequencies. Included is a data.frame of all 154 sonnets by Shakespeare.

```r
library(markovChains)
# Load the sonnet data and format as an observable Markov chain
sonnet_data <- observe_sonnet_chain()
# Estimate the first-order transition matrix
P <- estimate_dtmc(chain = sonnet_data$encodedChain, m = length(sonnet_data$stateSpace))
# Generate your new sonnet
sonnet <- markov_text(sonnet_data, P)
print(sonnet) # an example output:
# [1] "in pays bore paws last forebemoaned starved four composition possessing"            
# [2] "follow esteeming excusing nine worst word foregone wardrobe poverty famine"         
# [3] "huge dost love delights receives offences lovekindling refuse paid lame"            
# [4] "minion twixt paper sword us beweep hammered ear honest his"                         
# [5] "wastes preserve indirectly point crave dearpurchased alien towers oergreen disperse"
# [6] "brood each reeleth being weeds far wanton selfdoing played fashion"                 
# [7] "servant grow ragged hast womans unto estimate widows snow wights"                   
# [8] "fee betwixt loathsome hardest repair bath these wardrobe eat slumbers"              
# [9] "doing riot greet pent growst unknown once sufferance watching closet"               
# [10] "injurious woe fingers action flown shaken whose chronicle prevent dwellers"         
# [11] "souls selflove phrase potions lace whether no bearing hooks cunning"                
# [12] "reigns anothers view carve workings for comments thriftless awakes sufferance"      
# [13] "thing lacking returnd print attend trees impiety temptation jewels slain"           
# [14] "loathsome care made roses commits titles rather healthful sire wars"
```

### Simulating Ham On Rye

This one is going to be real non-sensical. 

```r
library(markovChains)
# Load the text data and format as an observable Markov chain
text_data <- observe_ham_on_rye() # use reducedSize = NULL for full 80,000 word chain
# Estimate the first-order transition matrix
P <- estimate_dtmc(chain = text_data$encodedChain, m = length(text_data$stateSpace))
# Generate your new text: default 14 lines with 10 words per line.
textout <- markov_text(text_data, P)
print(textout) # an example output:
# [1] "it 35 satin ship track worship peek checking hari cs"                                   
# [2] "prevent striped hunk jab dried mrs windmilled instructed depicted ma"                   
# [3] "nod doorways relentless tuition care stab sessions 523 purple rooting"                  
# [4] "platform christ fenster valves semi aplomb melodrama apes reach hoho"                   
# [5] "tits suicided meaningless next starched durham sisters dried 8th batter"                
# [6] "by staring 8 mutilated kittens refused disrobe shit let homo"                           
# [7] "handkerchief fall jungle track going flower webs surrendered glistening items"          
# [8] "blades stand jap bill successful handkerchiefs triumph scratched pomp corps"            
# [9] "docked pearshaped kicked equipment butts mere switch unmarred everybodys fly"           
# [10] "limping befriended toughest sit werent stopped homemade mates adopted energy"           
# [11] "indian mound effective crash tanks fantastic dull girlwoman candle fidget"              
# [12] "admired passes roast arguing gum timecard appointment worthwhile to rightwing"          
# [13] "clumps except fighter biologist greener nomansland meatballs kickoff equipment firm"    
# [14] "umpire windmilled deserved stretched mustard stockboy leading blackboards points morris"
```
