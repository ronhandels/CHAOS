source("scripts/R/read_checklist.R")

#' Combine every rating file under ratings/**/*.csv into one long-format table
#'
#' One row per (model, rater, item_id). Uses only base R.
#'
#' @param ratings_dir Directory containing one subfolder per model, each with
#'   one csv per rater (as produced by make_rating_template.R).
#' @param checklist_path Path to CHECKLIST.md, used to attach `domain` to each row.
#' @param out_path Where to write the merged file.
#' @return Invisibly, the merged data frame.
merge_ratings <- function(ratings_dir = "ratings",
                           checklist_path = "CHECKLIST.md",
                           out_path = file.path(ratings_dir, "_merged", "all_ratings.csv")) {

  files <- list.files(ratings_dir, pattern = "\\.csv$", recursive = TRUE, full.names = TRUE)
  files <- files[!grepl("_merged", files)]

  if (length(files) == 0) {
    message("No rating files found under ", ratings_dir)
    return(invisible(NULL))
  }

  all_ratings <- do.call(rbind, lapply(files, function(f) {
    read.csv(f, stringsAsFactors = FALSE, colClasses = "character")
  }))

  checklist <- read_checklist(checklist_path)[, c("item_id", "domain")]

  merged <- merge(all_ratings, checklist, by = "item_id", all.x = TRUE)

  # domain right after item_id, for readability
  ordered_cols <- c("item_id", "domain", setdiff(names(merged), c("item_id", "domain")))
  merged <- merged[, ordered_cols]
  merged <- merged[order(merged$model, merged$rater, merged$item_id), ]

  dir.create(dirname(out_path), recursive = TRUE, showWarnings = FALSE)
  write.csv(merged, out_path, row.names = FALSE)
  message("Wrote ", nrow(merged), " rows (", length(files), " files) to ", out_path)
  invisible(merged)
}

# Example, once you're ready to summarise (works once `rating` is numeric or
# you map Yes/Partial/No to a numeric scale first):
#
# merged <- merge_ratings()
# merged$score <- c(Yes = 1, Partial = 0.5, No = 0)[merged$rating]
# aggregate(score ~ model + domain, data = merged, FUN = mean, na.rm = TRUE)

if (sys.nframe() == 0) {
  merge_ratings()
}
