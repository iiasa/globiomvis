test_that("globiomvis is loaded for test", {
  expect_true("globiomvis" %in% loadedNamespaces())
})

test_that("package loads and detaches", {
  expect_error(devtools::load_all(".", reset=TRUE), NA)
  expect_true("globiomvis" %in% loadedNamespaces())
  expect_error(detach("package:globiomvis", unload=TRUE), NA)
  expect_false("globiomvis" %in% loadedNamespaces())
})
