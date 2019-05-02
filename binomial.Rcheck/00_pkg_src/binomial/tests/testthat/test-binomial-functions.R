context("check for binomial main functions")

x <- 10
y <- 0.3
#bin_choose
test_that("check bin_choose()", {
  expect_equal(bin_choose(5, 2), 10)
  expect_equal(bin_choose(3, 0), 1)
  expect_length(bin_choose(3, 1), 1)
  expect_type(bin_choose(8, 2), "double")
  expect_error(bin_choose(1, 3))
  expect_length(bin_choose(5, 1:3), 3)
})

#bin_probability
test_that("check bin_probability()", {
  expect_equal(bin_probability(3, 4, 0.5), 0.25)
  expect_equal(round(bin_probability(3, 4, 0.75), 3), round(0.4218), 3)
  expect_length(bin_probability(0:2, 5, 0.5), 3)
  expect_error(bin_probability(10, 5, 0.5))
})

#bin_distribution
test_that("check bin_distribution()", {
  expect_length(bin_distribution(7, 0.3)$probability, 8)
  expect_equal(sum(bin_distribution(7, 0.3)$probability), 1)
  expect_error(bin_distribution(3, -1))
})

#bin_cumulative
test_that("check bin_cumulative()", {
  expect_length(bin_cumulative(10, 0.3), 3)
  expect_equal(bin_cumulative(10, 0.3)$cumulative[11], 1)
  expect_error(bin_cumulative(10, 2))
})
