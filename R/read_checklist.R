#' Read the checklist markdown table into a data frame
#'
#' Parses the first Markdown table found in a file (by default CHECKLIST.md)
#' into a plain data frame. Uses only base R so no need to install
#' packages just to read the checklist.
#'
#' Assumes standard GitHub-flavoured Markdown table syntax, e.g.:
#'
#'   | item_id | domain | item |
#'   |---|---|---|
#'   | A1 | Accessibility | ... |
#'
#' @param path Path to the checklist file. Default "CHECKLIST.md".
#' @return A data frame with one row per checklist item, columns matching
#'   the table header (e.g. item_id, domain, item, response_options, guidance).
read_checklist <- function(path = "CHECKLIST.md") {

  lines <- trimws(readLines(path, warn = FALSE))
  table_lines <- lines[startsWith(lines, "|")]

  if (length(table_lines) < 2) {
    stop("No markdown table found in ", path)
  }

  split_row <- function(x) {
    x <- sub("^\\|", "", x)
    x <- sub("\\|$", "", x)
    trimws(strsplit(x, "\\|")[[1]])
  }

  header <- split_row(table_lines[1])

  # the second table line is the markdown separator row (e.g. |---|---|), skip it
  is_separator <- grepl("^[\\s|:-]+$", table_lines[2])
  data_lines <- if (is_separator) table_lines[-(1:2)] else table_lines[-1]

  rows <- lapply(data_lines, split_row)
  out <- as.data.frame(do.call(rbind, rows), stringsAsFactors = FALSE)
  names(out) <- header
  rownames(out) <- NULL
  out
}

# Allow `Rscript scripts/R/read_checklist.R` from the repo root as a quick check
if (sys.nframe() == 0) {
  print(read_checklist())
}

# Place checklist into a dataframe
df.checklist <- read_checklist()

