# Health-Economic Model Documentation Checklist (CHAOS)

A community-maintained checklist for rating the documentation quality of
open-source health-economic models, together with ratings of specific
models produced by applying it. 

Corresponding publication(s) can be found here: 

- [placeholder manuscript]

## Repository overview

- CHECKLIST.md : This file contains the checklist including rubric rating details. It is a living document — open a pull request to propose new items, reworded items, or clarified guidance. 
- scripts/R/ : This folder contains a script to read the checklist and create ratings. 

## Contribution instructions

### Proposing a change to the checklist itself

We welcome suggestions for improving the checklist. Open a pull request to propose new items, reword items, or clarify guidance. 

1. Edit `CHECKLIST.md`.
2. Keep `item_id` values stable — existing ratings reference items by `item_id`, so renumbering or deleting an ID breaks the link to every existing rating that used it. If an item needs retiring, keep its row and note in `guidance` that it's retired, rather than deleting it. Give new items a new, previously-unused ID.
3. Open a pull request. Checklist changes affect every future (and arguably every past) rating, so these are reviewed by a maintainer before merging.

### Adding a rating for a model

1. Create a new subfolder under the folder 'ratings'. Use a short `name` for the model. 
2. Create an empty rating file (e.g., copy a previous rating and empty it) with the same `name` as the subfolder. 
3. Make sure the `item_id` matches between your rating file and the checklist `version` you use; use only released versions of the checklist. 
4. Fill in the `rating` and `comment` columns (see rating file scheme below). Any spreadsheet, Google Sheets, or text editor works fine. 
5. Open a pull request. 

| column | description |
|---|---------|
| model | Model slug/name, lowercase with hyphens, consistent across every rater of that model and with model folder name |
| link | Link to model (repository), ideally specifically linking to any specific version used |
| version | Model version, such as github release or alternative; leave empty in case version is unknown which leaves any indication of version to the data assessed |
| date | Date of the rating in format `YYYY-MM-DD` |
| rater | Short identifier/username for the rater |
| profile | Link to rater profile such as organization or github profile page |
| rating | One of the checklist's `response_options`, e.g. `absent` / `basic` / `adequate` / `advanced` |
| comment | Free-text justification — optional but encouraged |
| item_id... | Multiple columns with each exactly match `item_id` in `CHECKLIST.md` |

## Appending ratings across models

```r
source("scripts/R/merge_ratings.R")
```

Rebuilds `ratings/_merged/all_ratings.csv`: one row per (model, rater, date), with `domain` attached from the checklist. Run this after adding new ratings if you want an up-to-date combined file committed to the repo.
