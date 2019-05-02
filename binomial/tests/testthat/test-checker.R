context("Check for checkers")

#check_prob
test_that("check check_prob", {
  expect_true(check_prob(1))
  expect_true(check_prob(0))
  expect_true(check_prob(0.5))

  expect_error(check_prob(-1))
  expect_error(check_prob(-4))

  expect_error(check_prob(0:2))
  expect_error(check_prob(0:10))
})

#check_trials
test_that("check check_trials", {
  expect_true(check_trials(10))
  expect_true(check_trials(0))

  expect_error(check_trials(1:5))
  expect_error(check_trials(-1:4))

  expect_error(check_trials(-2))
  expect_error(check_trials(-9))
})

#check_success
test_that("check check_success", {
  expect_true(check_success(10, 20))
  expect_true(check_success(0, 10))

  expect_true(check_success(1:10, 10))
  expect_error(check_success(1:11, 10))

  expect_error(check_success(-1, 10))
  expect_error(check_success(-2, 0))
})
