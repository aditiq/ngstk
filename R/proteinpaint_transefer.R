#' Function to convert mutation data to ProteinPaint \url{https://pecan.stjude.org/pp} input format.
#'
#' @param input_data A mutation data.frame need to be converted to ProteinPaint input.
#' @param input_type Point the input data format (iseq or others)
#' @param config_file ngstk ProteinPaint configuration file path, default is 
#' system.file('extdata', 'config/proteinpaint.toml', package = 'ngstk')
#' @param hander_funs hander function for single colnum, 
#' default is NULL and get value from config_file
#' @param mhander_funs hander function for mulitple colnums,
#' #' default is NULL and get value from config_file
#' @param hander_extra_params Extra parameters pass to handler
#' @param mhander_extra_params Extra parameters pass to mhandler
#' 
#' @return
#' A data frame
#' @export
#' @examples
#' demo_file <- system.file('extdata', 
#' 'demo/proteinpaint/mut2pp_iseq.txt', package = 'ngstk')
#' input_data <- read.table(demo_file, sep = '\t', header = TRUE, stringsAsFactors = FALSE)
#' disease <- 'T-ALL'
#' input_data <- data.frame(input_data, disease)
#' input_data$disease <- as.character(input_data$disease)
#' mut2pp(input_data, input_type = 'iseq')

mut2pp <- function(input_data, input_type = "iseq", config_file = system.file("extdata", "config/proteinpaint.toml", 
  package = "ngstk"), hander_funs = NULL, mhander_funs = NULL, hander_extra_params = NULL, mhander_extra_params = NULL) {
  config_meta <- eval.config(value = "meta", config = "mut2pp", file = config_file)
  defined_cols <- config_meta[["defined_cols"]][["colnames"]]
  if (is.null(hander_funs)) {
    hander_funs <- config_meta[["defined_cols"]][["hander_funs"]]
  }
  if (is.null(mhander_funs)) {
    mhander_funs <- config_meta[["defined_cols"]][["mhander_funs"]]
  }
  config_format <- eval.config(value = "format", config = "mut2pp", file = config_file)
  config_input <- config_format[[input_type]]
  hander_data <- NULL
  for (i in 1:length(defined_cols)) {
    hander_data <- proteinpaint_handler(hander_data, config_input, defined_cols, input_data, i, hander_funs, 
      hander_extra_params)
  }
  hander_data <- proteinpaint_mhandler(hander_data, config_input, mhander_funs, mhander_extra_params)
  return(hander_data)
}

#' Function to convert fusion data to ProteinPaint \url{https://pecan.stjude.org/pp} input format.
#'
#' @param input_data A gene fusions data.frame need to be converted to ProteinPaint input.
#' @param input_type Point the input data format (fusioncatcher or others)
#' @param config_file ngstk ProteinPaint configuration file path, default is 
#' system.file('extdata', 'config/proteinpaint.toml', package = 'ngstk')
#' @param hander_funs hander function for single colnum, 
#' default is NULL and get value from config_file
#' @param mhander_funs hander function for mulitple colnums,
#' #' default is NULL and get value from config_file
#' @param hander_extra_params Extra parameters pass to handler
#' @param mhander_extra_params Extra parameters pass to mhandler
#' @return
#' A data frame
#' @export
#' @examples
#' demo_file <- system.file('extdata', 
#' 'demo/proteinpaint/fusion2pp_fusioncatcher.txt', package = 'ngstk')
#' input_data <- read.table(demo_file, sep = '\t', header = TRUE, stringsAsFactors = FALSE)
#' disease <- 'B-ALL'
#' sampletype <- 'diagnose'
#' input_data <- data.frame(input_data, disease, sampletype)
#' input_data$disease <- as.character(input_data$disease)
#' hander_data <- fusion2pp(input_data, input_type = 'fusioncatcher')
fusion2pp <- function(input_data, input_type = "fusioncatcher", config_file = system.file("extdata", "config/proteinpaint.toml", 
  package = "ngstk"), hander_funs = NULL, mhander_funs = NULL, hander_extra_params = NULL, mhander_extra_params = NULL) {
  config_meta <- eval.config(value = "meta", config = "fusion2pp", file = config_file)
  defined_cols <- config_meta[["defined_cols"]][["colnames"]]
  if (is.null(hander_funs)) {
    hander_funs <- config_meta[["defined_cols"]][["hander_funs"]]
  }
  if (is.null(mhander_funs)) {
    mhander_funs <- config_meta[["defined_cols"]][["mhander_funs"]]
  }
  config_format <- eval.config(value = "format", config = "fusion2pp", file = config_file)
  config_input <- config_format[[input_type]]
  hander_data <- NULL
  for (i in 1:length(defined_cols)) {
    hander_data <- proteinpaint_handler(hander_data, config_input, defined_cols, input_data, i, hander_funs, 
      hander_extra_params)
  }
  hander_data <- proteinpaint_mhandler(hander_data, config_input, mhander_funs, mhander_extra_params)
  return(hander_data)
}

#' Function to convert fusion data to ProteinPaint heatmap meta rows \url{https://pecan.stjude.org/pp} input format.
#'
#' @param input_data A gene fusions data.frame need to be converted to ProteinPaint input.
#' @param input_type Point the input data format (fusioncatcher or others)
#' @param config_file ngstk ProteinPaint configuration file path, default is 
#' system.file('extdata', 'config/proteinpaint.toml', package = 'ngstk')
#' @param hander_funs hander function for single colnum, 
#' default is NULL and get value from config_file
#' @param mhander_funs hander function for mulitple colnums,
#' #' default is NULL and get value from config_file
#' @param hander_extra_params Extra parameters pass to handler
#' @param mhander_extra_params Extra parameters pass to mhandler
#' @return
#' A data frame
#' @export
#' @examples
#' demo_file <- system.file('extdata', 
#' 'demo/proteinpaint/fusion2pp_fusioncatcher.txt', package = 'ngstk')
#' input_data <- read.table(demo_file, sep = '\t', header = TRUE, stringsAsFactors = FALSE)
#' disease <- 'B-ALL'
#' sampletype <- 'diagnose'
#' input_data <- data.frame(input_data, disease, sampletype)
#' input_data$disease <- as.character(input_data$disease)
#' hander_data <- fusion2pp_meta(input_data, input_type = 'fusioncatcher')
fusion2pp_meta <- function(input_data, input_type = "fusioncatcher", config_file = system.file("extdata", 
  "config/proteinpaint.toml", package = "ngstk"), hander_funs = NULL, mhander_funs = NULL, hander_extra_params = NULL, 
  mhander_extra_params = NULL) {
  config_meta <- eval.config(value = "meta", config = "fusion2pp_meta", file = config_file)
  defined_cols <- config_meta[["defined_cols"]][["colnames"]]
  if (is.null(hander_funs)) {
    hander_funs <- config_meta[["defined_cols"]][["hander_funs"]]
  }
  if (is.null(mhander_funs)) {
    mhander_funs <- config_meta[["defined_cols"]][["mhander_funs"]]
  }
  config_format <- eval.config(value = "format", config = "fusion2pp_meta", file = config_file)
  config_input <- config_format[[input_type]]
  hander_data <- NULL
  for (i in 1:length(defined_cols)) {
    hander_data <- proteinpaint_handler(hander_data, config_input, defined_cols, input_data, i, hander_funs, 
      hander_extra_params)
  }
  hander_data <- proteinpaint_mhandler(hander_data, config_input, mhander_funs, mhander_extra_params)
  return(hander_data)
}


# main interface for proteinpaint data process
proteinpaint_handler <- function(hander_data, config_input, defined_cols, input_data, index, hander_funs = NULL, 
  extra_params = NULL) {
  
  hander_data <- handler(hander_data, config_input, defined_cols, input_data, index, hander_funs = hander_funs, 
    extra_params = extra_params)
  return(hander_data)
}

proteinpaint_mhandler <- function(hander_data, config_input, mhander_funs = NULL, extra_params = NULL) {
  
  hander_data <- mhandler(hander_data, config_input, mhander_funs, extra_params)
  return(hander_data)
}