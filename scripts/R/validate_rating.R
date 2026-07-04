source("scripts/R/read_checklist.R")

#' Validate a single rating CSV against the current checklist
#'
#' @param rating_path Path to a rating csv, e.g. "ratings/my-model/yourname_2026-07-04.csv"
#' @param checklist_path Path to CHECKLIST.md
#' @param allowed_ratings Character vector of permitted values in the `rating` column.
#'   Empty string and NA are always allowed (an item left blank), everything else
#'   must be one of these.
#' @return TRUE if valid; otherwise throws an error describing every problem found.
validate_rating <- function(rating_path,
                             checklist_path = "CHECKLIST.md",
                             allowed_ratings = c("Yes", "Partial", "No", "NA")) {

  checklist <- read_checklist(checklist_path)
  rating <- read.csv(rating_path, stringsAsFactors = FALSE, colClasses = "character")

  problems <- character(0)

  required_cols <- c("item_id", "model", "rater", "date", "rating", "comment")
  missing_cols <- setdiff(required_cols, names(rating))
  if (length(missing_cols) > 0) {
    problems <- c(problems, paste("Missing column(s):", paste(missing_cols, collapse = ", ")))
  }

  if ("item_id" %in% names(rating)) {
    missing_items <- setdiff(checklist$item_id, rating$item_id)
    extra_items   <- setdiff(rating$item_id, checklist$item_id)
    dup_items     <- rating$item_id[duplicated(rating$item_id)]

    if (length(missing_items) > 0)
      problems <- c(problems, paste("Missing item_id(s):", paste(missing_items, collapse = ", ")))
    if (length(extra_items) > 0)
      problems <- c(problems, paste("Unknown item_id(s) not in checklist:", paste(extra_items, collapse = ", ")))
    if (length(dup_items) > 0)
      problems <- c(problems, paste("Duplicate item_id(s):", paste(unique(dup_items), collapse = ", ")))
  }

  if ("rating" %in% names(rating)) {
    values <- rating$rating[!is.na(rating$rating) & rating$rating != ""]
    bad_values <- setdiff(unique(values), allowed_ratings)
    if (length(bad_values) > 0)
      problems <- c(problems, paste("Unrecognised rating value(s):", paste(bad_values, collapse = ", ")))
  }

  if (length(problems) > 0) {
    stop(paste0(rating_path, " failed validation:\n- ", paste(problems, collapse = "\n- ")))
  }

  TRUE
}

# Allow `Rscript scripts/R/validate_rating.R ratings/my-model/yourname_2026-07-04.csv`
if (sys.nframe() == 0 && length(commandArgs(trailingOnly = TRUE)) >= 1) {
  path <- commandArgs(trailingOnly = TRUE)[1]
  if (isTRUE(validate_rating(path))) message(path, " is valid.")
}
