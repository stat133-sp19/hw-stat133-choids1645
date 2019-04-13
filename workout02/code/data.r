#' @title Future Value
#' @description calcululate the future value of an investment
#' @param amount initial invested amount
#' @param rate annual rate of return
#' @param years numbers of years
#' @return computed future value
future_value <- function(amount, rate, years) {
  return(amount * (1+rate) ^ years)
}


#' @title Future Value of Annuity
#' @description calcululate the future value of an investment
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param years numbers of years
#' @return computed future value
annuity <- function(contrib, rate, years) {
  return((contrib * ((1+rate)^years - 1)/rate))
}


#' @title Future Value of Growing Annuity
#' @description calcululate the future value of an investment
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param growth annual growth rate
#' @param years numbers of years
#' @return computed future value of growing annuity
growing_annuity <- function(contrib, rate, growth, years) {
  return((contrib * ((1+rate)^years - (1+growth)^years)/(rate-growth)))
}
