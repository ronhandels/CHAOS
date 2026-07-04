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

### Adding a rating for a model you haven't rated before

1. From the repository root, in R:
   ```r
   source("scripts/R/make_rating_template.R")
   make_empty_rating_template(model = "my-model", rater = "yourname")
   ```
   This writes `ratings/my-model/yourname_<date>.csv`, pre-filled with every current `item_id` so nothing is missed or mistyped. Use the same `model` slug that others rating the same model have used (check `ratings/` first).
2. Fill in the `rating` and `comment` columns (see rating file scheme below). Any spreadsheet, Google Sheets, or text editor works fine. 
3. Open a pull request. `.github/workflows/validate-ratings.yml` runs `scripts/R/validate_rating.R` automatically and checks that your file has the right columns, that every current `item_id` is present exactly once, and that every `rating` value is one of the checklist's allowed options.

| column | description |
|-|-----|
| item_id | Must exactly match an `item_id` in `CHECKLIST.md` |
| model | Model slug/name, lowercase with hyphens, consistent across every rater of that model and with model folder name |
| rater | Short identifier/username for the rater |
| profile | Link to rater profile such as organization or github profile page | 
| date | Date of the rating in format `YYYY-MM-DD` |
| rating | One of the checklist's `response_options`, e.g. `absent` / `basic` / `adequate` / `advanced` |
| comment | Free-text justification — optional but encouraged |

### Editing an existing rating

Open a pull request editing the specific `ratings/<model>/<rater>_<date>.csv` file directly. Explain your reasoning in the PR description, and where possible let the original rater review the PR before it's merged. Because each rater has their own file, a suggested change is always clearly attributed and can't silently overwrite someone else's rating.

By default, this repository keeps **one file per rater per model** and does
not force raters to agree. This keeps the bar for contributing a new,
independent rating low (no adjudicator needed to accept it), and preserves
rater-level detail that's useful in its own right — e.g. for computing
inter-rater agreement, or seeing which checklist items tend to divide
opinion, which is itself useful feedback on the checklist.

If you'd like to additionally record a **consensus** rating for a model
(e.g. because several people have rated it and want to reconcile the
differences into one agreed assessment), the process is:

1. Open an issue listing the model and the `item_id`s where raters disagree,
   tagging the existing raters of that model.
2. Once discussion converges, open a pull request adding
   `ratings/<model>/consensus.csv` (same schema as any other rating file,
   with `rater` set to `"consensus"`).
3. That pull request should be reviewed and approved by each rater who contributed an
   independent rating for that model (or, if someone is unavailable, by a
   maintainer) before merging.

Independent, per-rater files are never deleted or overwritten by a
consensus rating — `consensus.csv` is additive, so the underlying
disagreement stays visible for anyone who wants to look at it.

## Appending ratings across models

```r
source("scripts/R/merge_ratings.R")
merge_ratings()
```

Rebuilds `ratings/_merged/all_ratings.csv`: one row per (model, rater, item_id),
with `domain` attached from the checklist. Run this after adding new ratings
if you want an up-to-date combined file committed to the repo.
