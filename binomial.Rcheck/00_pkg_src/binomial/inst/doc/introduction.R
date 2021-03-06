## ---- echo=FALSE, message=FALSE------------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
library(binomial)

## ------------------------------------------------------------------------
c <- bin_choose(10, 5)
c

## ------------------------------------------------------------------------
p <- bin_probability(2, 5, 0.5)
p

## ------------------------------------------------------------------------
bd <- bin_distribution(5, 0.5)
bd
plot(bd)

## ------------------------------------------------------------------------
bc <- bin_cumulative(5, 0.5)
bc
plot(bc)

## ------------------------------------------------------------------------
bv <- bin_variable(5, 0.5)
bv
summary(bv)

## ------------------------------------------------------------------------
bin_mean(5, 0.5)

## ------------------------------------------------------------------------
bin_variance(5, 0.5)

## ------------------------------------------------------------------------
bin_mode(5, 0.5)

## ------------------------------------------------------------------------
bin_skewness(5, 0.5)

## ------------------------------------------------------------------------
bin_kurtosis(5, 0.5)

