# Run this from the repository root (e.g. an RStudio project opened at the
# top level, or `Rscript scripts/R/make_rating_template.R <model> <rater>`).

source("scripts/R/read_checklist.R")

#' Create a blank rating file for a model/rater, pre-filled with every
#' current checklist item_id so nothing gets missed or mistyped.
#'
#' @param model Short slug for the model, e.g. "my-model" (lowercase, hyphens).
#'   Use the same slug every time this model is rated, by any rater.
#' @param rater Short identifier for the rater, ideally a GitHub username.
#' @param date Date of rating, default today, format YYYY-MM-DD.
#' @param checklist_path Path to the checklist file.
#' @return Invisibly, the path to the file written.
make_empty_rating_template <- function(
    model, 
    rater,
    date = format(Sys.Date(), "%Y-%m-%d"),
    checklist_path = "CHECKLIST.md") 
  {
  
  stopifnot(is.character(model), is.character(rater))
  
  checklist <- read_checklist(checklist_path)
  
  template <- data.frame(
    item_id = checklist$item_id,
    model   = model,
    rater   = rater,
    date    = date,
    rating  = NA_character_,
    comment = "",
    stringsAsFactors = FALSE
  )

  dir_path <- file.path("ratings", model)
  dir.create(dir_path, recursive = TRUE, showWarnings = FALSE)

  file_path <- file.path(dir_path, paste0(rater, "_", date, ".csv"))

  if (file.exists(file_path)) {
    stop("File already exists - edit it directly instead of regenerating: ", file_path)
  }

  write.csv(template, file_path, row.names = FALSE)
  message("Template written to ", file_path)
  invisible(file_path)
}

# Allow `Rscript scripts/R/make_rating_template.R my-model yourname` from the CLI
if (sys.nframe() == 0 && length(commandArgs(trailingOnly = TRUE)) >= 2) {
  args <- commandArgs(trailingOnly = TRUE)
  make_rating_template(model = args[1], rater = args[2])
}
