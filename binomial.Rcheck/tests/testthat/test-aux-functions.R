context("check for private auxiliary functions")
x <- 10
y <- 0.3
#aux_mean
test_that("check aux_mean", {
  mu <- aux_mean(x, y)
  expect_equal(mu, 3)
  expect_length(mu, 1)
  expect_type(mu, 'double')
})

#aux_variance
test_that("check aux_variance", {
  v <- aux_variance(x, y)
  expect_equal(v, 2.1)
  expect_length(v, 1)
  expect_type(v, 'double')
})

#aux_mode
test_that("check aux_mode", {
  mo <- aux_mode(x, y)
  expect_equal(mo, 3)
  expect_equal(aux_mode(9, 0.5), c(5, 4))
  expect_length(mo, 1)
  expect_type(mo, "double")
})

#aux_skewness
test_that("check aux_skewness", {
  sk <- aux_skewness(x, y)
  expect_equal(round(sk, 3), round(0.2760262, 3))
  expect_length(sk, 1)
  expect_type(sk, "double")
})

#aux_kurtosis
test_that("check aux_kurtosis", {
  k <- aux_kurtosis(x, y)
  expect_equal(round(k, 3), round(-0.1238095, 3))
  expect_length(k, 1)
  expect_type(k, "double")
})
