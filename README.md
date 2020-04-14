
# markovChains

<!-- badges: start -->
<!-- badges: end -->

The goal of markovChains is to provide basic simulation, estimation and modeling schemes, routines and functions in R for both discrete time and continuous time matrices.


## Features

- [x] Simulating both discrete and continuous time Markov chains
- [x] Estimating the transition matrices of discrete and continuous time chains
- [x] Computing the stationary distribution if it exists of DTMCs
- [ ] Computing the stationary distribution if it exists of DTMCs
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
### Simulating a Shakespearean "Sonnet"
Okay this will not actually follow the rhyming scheme of a sonnet, but it will give off a mild Shakespearean effect by using his vocab and first-order word frequencies. Included is a data.frame of all 154 sonnets by Shakespeare.
```r
library(markovChains)
# Load the sonnet data and format as an observable Markov chain
sonnet_data <- observe_sonnet_chain()
# Estimate the first-order transition matrix
P <- estimate_dtmc(chain = sonnet_data$encodedChain, m = length(sonnet_data$stateSpace))
# Generate your new sonnet
sonnet <- markov_sonnet(sonnet_data, P)
print(sonnet)
```


