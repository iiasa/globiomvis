test_that("package loads and detaches", {
  expect_error(devtools::load_all(".", reset=TRUE), NA)
  expect_true("rglobiom" %in% loadedNamespaces())
  expect_error(detach("package:rglobiom", unload=TRUE), NA)
  expect_false("rglobiom" %in% loadedNamespaces())
})
