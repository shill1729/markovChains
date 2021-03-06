% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/semigroup.R
\name{semigroup}
\alias{semigroup}
\title{Numerically compute the transition matrix of a CTMC given the generator matrix}
\usage{
semigroup(t, Q)
}
\arguments{
\item{t}{time input}

\item{Q}{generator matrix, also called Q-matrix, and transition-rate matrix.}
}
\value{
matrix
}
\description{
{Computes \eqn{P(t)=e^{tQ}}, numerically}
}
\details{
{The exponential of a matrix is defined by the Taylor series \eqn{\sum (tQ)^n/n!}}
}
