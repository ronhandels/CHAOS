#' Read the checklist markdown table into a data frame

# Install dplyr package if not yet installed
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

# Load dplyr package
library(dplyr)

# Get all CSV files recursively
files <- list.files(
  path = "ratings",
  pattern = "\\.csv$",
  recursive = TRUE,
  full.names = TRUE
)

# Remove any file inside "_merged" folders
files <- files[!grepl("/_merged/", files)]

# Read all files into a list
data_list <- lapply(files, function(f) {
  read.csv(f, stringsAsFactors = FALSE)
})

# Combine using bind_rows (matches by column name)
all_ratings <- bind_rows(data_list)

# Write CSV file
write.csv(x=all_ratings, file="ratings/_merged/all_ratings.csv", na = "")