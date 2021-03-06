% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/binomial.R
\name{bin_distribution}
\alias{bin_distribution}
\title{bin_distribution}
\usage{
bin_distribution(trials, prob)
}
\arguments{
\item{trials}{number of trials}

\item{prob}{probability of getting success}
}
\value{
a data frame object of class bindis and data.frame
}
\description{
create a data frame with the number of successes and probability of getting such successes
}
\examples{
bin_distribution(trials = 5, prob = 0.5)
}
