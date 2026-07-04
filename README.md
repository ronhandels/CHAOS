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