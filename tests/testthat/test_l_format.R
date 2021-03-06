test_that("format_filenames", {
  
  files_dir <- system.file("extdata", "demo/format", package = "ngstk")
  pattern <- "*.txt"
  x <- format_filenames(files_dir = files_dir, pattern = pattern, profix = "hg38_")
  x <- unname(x)
  x <- sort(x)
  x <- basename(x)
  expect_that("hg38_cancer_circrna.txt" %in% x, equals(TRUE))
  expect_that("hg38_cancer_circrna_mre.txt" %in% x, equals(TRUE))
  expect_that("hg38_common_circrna.txt" %in% x, equals(TRUE))
  x <- format_filenames(files_dir = files_dir, pattern = pattern, profix = "hg38_", 
    toupper = TRUE)
  x <- unname(x)
  x <- sort(x)
  x <- basename(x)
  expect_that(toupper("hg38_cancer_circrna.txt") %in% x, equals(TRUE))
  x <- format_filenames(files_dir = files_dir, pattern = pattern, profix = "hg38_", 
    toupper = TRUE, tolower = TRUE)
  x <- unname(x)
  x <- sort(x)
  x <- basename(x)
  expect_that("hg38_cancer_circrna.txt" %in% x, equals(TRUE))
})
