#private checker functions
#check_prob
#private auxiliary function that tests if an input prob is a valid probaility
#prob input probability
#whether an input is a valid probability or not
check_prob <- function(prob) {
  if(length(prob) != 1) {
    stop("prob should be one value, not a vector")
  }
  if(prob >= 0 & prob <= 1) {
    return(TRUE)
  }
  stop("invalid prob value")
}

#check_trials
#private auxiliary function that tests if an input trials is a valid value for number of trials
#trials input trials
#whether an input is valid trials or not
check_trials <- function(trials) {
  if(length(trials) != 1) {
    stop("trials should be one value, not a vector")
  }
  if(trials >= 0) {
    return(TRUE)
  }
  stop("invalid trials value")
}

#check_success
#private auxiliary function that tests if an input success is valid number of successes
#success number of successes which is less than or equal to trials
#trials input trials
#whether an input is valid number of success or not
check_success <- function(success, trials) {
  for(i in 1:length(success)) {
    if(success[i] < 0) {
      stop("invalid success value")
    } else if(success[i] > trials) {
      stop("success cannot be greater than trials")
    }
  }
  return(TRUE)


}

##private auxiliary functions

#title aux_mean
#description compute mean value
#param trials input trials
#param prob input probability
#return computed mean
aux_mean <- function(trials, prob) {
  return(trials*prob)
}

#title aux_variance
#description compute variance value
#param trials input trials
#param prob input probability
#return computed variance
aux_variance <- function(trials, prob) {
  return(trials*prob*(1-prob))
}

#title aux_mode
#description compute mode value
#param trials input trials
#param prob input probability
#return computed mode
aux_mode <- function(trials, prob) {
  m <- trials*prob + prob
  if(m %% 1 == 0) {
    return(c(m, m-1))
  }
  return(as.integer(m))
}

#title aux_skewness
#description compute skewness value
#param trials input trials
#param prob input probability
#return computed skewness
aux_skewness <- function(trials, prob) {
  return((1-2*prob)/sqrt(aux_variance(trials, prob)))
}

#title aux_kurtosis
#description compute kurtosis value
#param trials input trials
#param prob input probability
#return computed kurtosis
aux_kurtosis <- function(trials, prob) {
  return((1-6*prob*(1-prob))/aux_variance(trials, prob))
}

##main functions

#' @title bin_choose
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of trials
#' @param k number of successes
#' @return n choose k
#' @export
#' @examples
#' \dontrun{
#' bin_choose(n=5, k=2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)
#' }
bin_choose <- function(n, k) {
  if(check_trials(n) & check_success(k, n)) {
    return(factorial(n)/(factorial(k)*factorial(n-k)))
  }
}

#' @title bin_probability
#' @description calculates the probability of getting k successes in n trials
#' @param success number of success
#' @param trials number of trials
#' @param prob probability of getting success
#' @return calculated probability
#' @export
#' @examples
#' bin_probability(success=2, trials=5, prob=0.5)
#' bin_probability(success=0:2, trials=5, prob=0.5)
#' bin_probability(success=55, trials=100, prob=0.45)
bin_probability <- function(success, trials, prob) {
  if(check_trials(trials) & check_prob(prob) & check_success(success, trials)) {
    return(bin_choose(trials, success) * (prob^success) * ((1-prob)^(trials-success)))
  }
}

#' @title bin_distribution
#' @description create a data frame with the number of successes and probability of getting such successes
#' @param trials number of trials
#' @param prob probability of getting success
#' @return a data frame object of class bindis and data.frame
#' @export
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials, prob) {
  df <- data.frame(success = 0:trials, probability = bin_probability(0:trials, trials, prob))
  structure(df, class = c("bindis", "data.frame"))
}

#' @export
plot.bindis <- function(dist) {
  barplot(dist$probability, xlab = "success", ylab = "probability",
          names.arg = dist$success)
}

#' @title bin_cumulative
#' @description create a data frame with the number of successes, and corresponding probabilities and cumulative probabilities
#' @param trials number of trials
#' @param prob probability of getting success
#' @return a data frame object of class bincum and data.frame
#' @export
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials, prob) {
  df <- bin_distribution(trials, prob)
  df <- cbind(df, cumulative = cumsum(df$probability))
  class(df) <- c("bincum", "data.frame")
  return(df)
}

#' @export
plot.bincum <- function(dist) {
  plot(dist$success, dist$cumulative, type = 'o',
       xlab = 'success', ylab = 'probability')
}

#' @title bin_variable
#' @description returns a binomial random variable
#' @param trials number of trials
#' @param prob probability of getting success
#' @return an object of class binvar
#' @export
#' @examples
#' bin_variable(trials = 10, p = 0.3)
bin_variable <- function(trials, p) {
  if(check_trials(trials) & check_prob(p)) {
    variable <- list(trials = trials, prob = p)
    class(variable) <- "binvar"
    return(variable)
  }
}

#' @export
print.binvar <- function(var) {
  cat('"Binomial variable"\n\n')
  cat('Parameters\n')
  cat('- number of trials:', var[[1]])
  cat('\n- prob of success :', var[[2]])
  invisible(var)
}

#' @export
summary.binvar <- function(var) {
  trials <- var[[1]]
  prob <- var[[2]]
  mean <- aux_mean(trials, prob)
  variance <- aux_variance(trials, prob)
  mode <- aux_mode(trials, prob)
  skewness <- aux_skewness(trials, prob)
  kurtosis <- aux_kurtosis(trials, prob)
  out_list <- list(trials = trials,
                   prob = prob,
                   mean = mean,
                   variance = variance,
                   mode = mode,
                   skewness = skewness,
                   kurtosis = kurtosis)
  class(out_list) <- "summary.binvar"
  return(out_list)
}

#' @export
print.summary.binvar <- function(var) {
  cat('"Summary Binomial"\n\n')
  cat('Parameters\n')
  cat('- number of trials:', var[[1]], '\n')
  cat('- prob of success :', var[[2]], '\n\n')

  cat('Measures\n')
  cat('- mean    :', var[[3]], '\n')
  cat('- variance:', var[[4]], '\n')
  cat('- mode    :', var[[5]], '\n')
  cat('- skewness:', var[[6]], '\n')
  cat('- kurtosis:', var[[7]], '\n')
  invisible(var)
}

#' @title bin_mean
#' @description calculate the mean
#' @param trials number of trials
#' @param prob probability of getting a success
#' @return calculated mean value
#' @export
#' @examples
#' bin_mean(10, 0.3)
bin_mean <- function(trials, prob) {
  if(check_trials(trials) & check_prob(prob)) {
    return(aux_mean(trials, prob))
  }
}

#' @title bin_variance
#' @description calculate the variance
#' @param trials number of trials
#' @param prob probability of getting a success
#' @return calculated variance value
#' @export
#' @examples
#' bin_variance(10, 0.3)
bin_variance <- function(trials, prob) {
  if(check_trials(trials) & check_prob(prob)) {
    return(aux_variance(trials, prob))
  }
}

#' @title bin_mode
#' @description calculate the mode
#' @param trials number of trials
#' @param prob probability of getting a success
#' @return calculated mode value
#' @export
#' @examples
#' bin_mode(10, 0.3)
bin_mode <- function(trials, prob) {
  if(check_trials(trials) & check_prob(prob)) {
    return(aux_mode(trials, prob))
  }
}

#' @title bin_skewness
#' @description calculate the skewness
#' @param trials number of trials
#' @param prob probability of getting a success
#' @return calculated skewness value
#' @examples
#' bin_skewness(10, 0.3)
#' @export
bin_skewness <- function(trials, prob) {
  if(check_trials(trials) & check_prob(prob)) {
    return(aux_skewness(trials, prob))
  }
}

#' @title bin_kurtosis
#' @description calculate the kurtosis
#' @param trials number of trials
#' @param prob probability of getting a success
#' @return calculated kurtosis value
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials, prob) {
  if(check_trials(trials) & check_prob(prob)) {
    return(aux_kurtosis(trials, prob))
  }
}

