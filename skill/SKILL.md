---
name: chaos-model-review
description: Guide to apply the CHecklist for Assessing Open Source health economic models (CHAOS) to assess the documentation quality of an open-source model. First, it reads in the CHAOS checklist as well as an open-source model (typically the files from a repository like GitHub). Second, it scores each item of the checklist against the open-source model. Third, it provides its scores in the form of a template table as well as in the form of a list alongside an explanation how it arrived at those scores and the certainty of the scores. Fourth, optionally, it produces recommendations for improving the documentation quality of the open-source model. It does not run the model to test its reproducibility. 
---

# CHAOS model review

Applies the 10-item CHecklist for Assessing Open Source health economic models (CHAOS) to a specific user-provided open-source health-economic model. It produces for each checklist item its score, evidence comments (i.e., a short explanation how it arrived at a score) and its scoring certainty. This is provided in the format of a template table as well as a list. 

# Core workflow (3 Phases)

## Phase 1: Take in all materials

Take in all material from the following steps. Do not provide any scores at this phase 1. 

### Step 1: Read the reference files

1. https://github.com/ronhandels/CHAOS/blob/main/CHECKLIST.md — Import in full this CHAOS checklist rubric consisting of 10 items with mostly 4 scoring categories.
2. https://github.com/ronhandels/CHAOS/blob/main/docs/manuscript.pdf — Read the manuscript describing the background, rationale, development, item explanations and validation of the checklist. Focus on the first part of the results providing detail to each checklist item. 

### Step 2: Read the open source model files

A user should provide the open-source model files, either by providing a link to the model's repository link or by uploading the model files. If the user hasn't already given a repository URL or model files, ask for it. Only use the main branch regardless of what other branches exist, and confirm this to the user. 

### Step 3: Read the scoring rules

The CHAOS rubric wording (`CHECKLIST.md`) is intentionally general. The following descriptions add repeatable rules so that ratings from different runs (and from different repositories) are as consistent and as independently verifiable as possible. 

#### MD1 — Meta data - Starting point / README

Check: README file in repository root directory; any root-level file whose name plainly signals it's the entry point (e.g., GETTING_STARTED or INDEX); notebook/vignette file (e.g., in docs or vignette folder); project wiki link in repository description. 

Look for the following 4 sub-elements and rate each as present/absent. 

1. Statement of the goal or purpose of the model. 
2. Developer/maintainer name and contact information (e.g. email, an institutional page, an ORCID, a GitHub/GitLab handle). Consider missing contact information as partly satisfied and let it pull the item toward the lower tier. 
3. Publication reference (ideally with DOI) or document introducing the model and describing its results. 
4. Guidance how to install the model (e.g., for an R script on GitHub this includes an instruction to save/clone the repository, install R (and RStudio) and install packages; latter only if applicable). Guidance should be short (i.e., not intertwined with detailed documentation on model methodology description). 

Decision: 

- **Absent**: 0 of 4 present, or no README/equivalent or present but insufficiently clearly described. 
- **Basic**: 1 or 2 of 4. 
- **Adequate**: 3 of 4. 
- **Advanced**: 4 of 4. 

#### MD2 — Meta data - Run guidance

Check: README file in repository root directory; any root-level file whose name plainly signals it's usage, how to run or quick start (e.g., GETTING_STARTED); notebook/vignette file (e.g., in docs or vignette folder); project wiki link in repository description; comments at the top of an obvious entry-point script. 

Look for the following 5 sub-elements and rate each as present/absent: 

1. Starting file/script location is mentioned or referred to. 
2. Inputs list/file location is mentioned or referred to. 
3. Functions or scripts to run the model is referred to and a short description of its workflow is provided. 
4. Functions or scripts to produce outcomes is mentioned or referred to (which script/function to run to get outputs and where outcomes land). 
5. An indication of the model runtime is provided (only if a run would plausibly exceed ~1 minute e.g., with micrisomulation models). 

Decision: 

- **Absent**: 0 of 5 present, or no README/equivalent or present but insufficiently clearly described. 
- **Basic**: 1 or 2 of 5. 
- **Adequate**: 3 or 4 of 5. 
- **Advanced**: 5 of 5. 

**Note**: If runtime is trivially short, don't penalize for its absence — note "5" as not applicable rather than missing. 

#### MD3 — Meta data - License

Check: LICENSE, COPYING, license badge in README, license field in `DESCRIPTION` (R packages) or `package.json`. 

Decision: 

- **Absent**: No license file or declaration anywhere, or license terms are unclear/proprietary/"all rights reserved". A license is present but its openness is genuinely ambiguous (custom license text, unclear terms); note this in the evidence comment and set certainty of this item to `Low`. 
- **Advanced**: A recognized open license present is provided (e.g., MIT, Apache-2.0, BSD-2/3-Clause, GPL-2/3, LGPL, MPL, etc.). A Creative Commons license is present, but add a notification in the evidence comment that CC licenses are not recommended for software/open-source models. 

#### MD4 — Meta data - Package & dependencies

Check: README file in repository root directory; any root-level file whose name plainly signals it's packages and dependencies; `DESCRIPTION` (R), `renv.lock` / `packrat.lock`, `requirements.txt` / `Pipfile.lock` / `poetry.lock` / `environment.yml` (Python), `sessionInfo()` output pasted anywhere, `Dockerfile`. 

Decision: 

- **Absent**: No language/package list provided. 
- **Basic**: Language and package names are listed, but no version numbers are provided. 
- **Adequate**: Language and package names and their version numbers are listed, even if no separate dependency-description artifact (e.g. pasted `sessionInfo()` output, a `pip freeze` dump) is given. A description of dependencies alongside the versions is a plus but not required to reach this tier. 
**Advanced**: - An actual lockfile / reproducible-environment artifact present (`renv.lock`, `poetry.lock`, pinned `environment.yml`, `Dockerfile` that builds a pinned environment, or distributed as a versioned package). 

**Note**: In case no packages are loaded or used in any of the scripts, consider a package list as not applicable and only judge the coding language provided. 

#### MD5 — Meta data - Model version (history)

Check: README file in repository root directory, `CHANGELOG.md`, `NEWS.md`, `DESCRIPTION` `Version:` field (R packages) or an equivalent language-specific version field; the repo's releases/tags on its hosting platform (e.g. GitHub Releases/tags, GitLab Releases/tags), Zenodo badge/DOI.

Decision: 

- **Absent**: No version indication anywhere. 
- **Basic**: A bare version number and/or date only, but no or insufficiently clear description of what changed. 
- **Adequate**: Version(s)/release(s) described with a sufficiently clear description of changes. 
- **Advanced**: Versions/releases tracked via the repo hosting platform's own functionality (e.g. GitHub Releases/tags, GitLab Releases/tags,   Zenodo archive) with an accompanying changelog, ideally using conventional naming (`vMAJOR.MINOR.PATCH`). 

#### CQ1 — Coding quality - Folder structure

Check: the top-level directory or one sub-level for any meaningful structure.

Decision: 

- **Absent**: Model inputs and model functions/scripts and model outputs are mixed in one file or one folder. 
- **Basic**: Separate folders for model inputs, model functions/scripts, and model outputs, with human-readable folder names. Penalize for separate files but not separate folders. 
- **Adequate**: A recognizable health-economic-modelling template folder structure is used (e.g. DARTH coding framework, which has folders `data-raw`, `data`, `R`, `analysis`, `output`, `figs`, `tables`, `report`, `vignettes`, `tests`), or a folder structure that closely resembles one in spirit even if it doesn't match exactly. 
- **Advanced**: A widely-used general software structure is used (e.g. a language's standard package layout, such as an R package's `R/`, `man/`,   `tests/`, `DESCRIPTION`, `NAMESPACE`, or an equivalent standard project layout in another language). 

#### CQ2 — Coding quality - Consistent style

Check: the most central code files such as the scripts read the input data, contain the model functions and run the model and produce its results (don't need to read every file). 

Check the following 6 sub-elements and rate each as present/absent: 

1. Human-readable object/variable names (not single letters/cryptic abbreviations). 
2. A consistent file and variable naming convention (e.g., DARTH convention for files `dir/component-number_description_ext` (e.g., `analysis/01_model_inputs.R`), for functions `action!_description` (e.g., `generate_init_params()`) and for variables `data-prefix_variable-prefix_brief-descriptor` (e.g., `v_r_mort_by_age`). This is normally a single convention throughout (e.g. `snake_case`, `camelCase` or `dot.notation`, not randomly mixed). However, a convention can also count as satisfying this sub-element if the mixing is applied consistently across object categories e.g. using a `.` for a prefix and a `_` for separating words within the name (e.g., `v.coeff_age`). Judge by whether a reader can predict the pattern from a few examples. Note in the evidence comment which pattern (single or purposeful-mixed) was observed. 
3. Prefix for data type (e.g., DARTH convention `v_`, `m_`, `a_`, `df_`, `dtb`, `l_` for vector/matrix/array/data-frame/data-table/list). 
4. Prefix for variable type (e.g., DARTH convention `n`, `p_`, `r`, `u_`, `c_`, `hr_`, `rr_`, `ly`, `q`, `se` for number/probability/rate/utility/cost/hazard-ratio/relative-risk/life-years/qalys/standard-error); or an equivalent convention. 
5. Consistent code spacing (around operators, after commas), following recommendations from a coding framework such as https://style.tidyverse.org/. 
6. Consistent indentation, following recommendations from a coding framework such as https://style.tidyverse.org/. 

Decision: 

- **Absent**: 1 of 6. 
- **Basic**: 2 or 3 of 6. 
- **Adequate**: 4 or 5 of 6. 
- **Advanced**: 6 of 6. 

**Note**: Accept inconsistencies only if they occur by exception. In case of different ratings per file/script, create an average score from them and round off downwards as an indication of inconsistency. 

#### CQ3 — Coding quality - Coding documentation

Check: the most central code files such as the scripts read the input data, contain the model functions and run the model and produce its results (don't need to read every file) and check any inline comments and section headers within code files (e.g., by `#` or `//`); dedicated docs/vignettes folder (e.g. `vignettes/` for an R package); auto-generated API/package documentation (e.g. R's `roxygen2`-generated `man/` pages and pkgdown sites, Python's Sphinx or mkdocs output, or equivalent tooling in another language); any narrative walk through document separate from the README. 

Decision: 

- **Absent**: No inline comments/headings. 
- **Basic**: Inline headings and inline comments are present but no separate description of the overall model flow is provided. 
- **Adequate**: Inline headings and comments are present and a separate description of the overall model flow is provided. 
- **Advanced**: Inline headings and comments and a vignette or generated package/API documentation is provided (e.g. roxygen2/`man/`/pkgdown for R, Sphinx/mkdocs for Python). 

#### CQ4 — Coding quality - Functions / modules

Check: the most central code files such as the scripts read the input data, contain the model functions and run the model and produce its results (don't need to read every file). 

Decision: 

- **Absent**: The model is coded as a single script with no functions used. 
- **Basic**: The model is coded as a single function (or nearly so) and inputs/analysis are mostly inline in one script. 
- **Adequate**: The model is coded as a small number of functions with distinct aims (e.g. a function preparing inputs and a function to run the model). - **Advanced**: THe model is fully modularized with separate and clearly ordered functions for input preparation, running the model, running analyses, and (if applicable) calibration/validation. 

#### RE1 — Reproducibility - Execution reproducibility

Do not assess this item. This item is skipped for any AI based assessment. Do not execute or run any code. Do not provide any score for this item. 

### Step 4: Read in the general principles

The following general principles apply to every item: 

- Sub-elements should not be judged merely present/absent. Also judge whether sub-elements (e.g., of the meta data items) are sufficiently clearly described. In case insufficiently clear, score it similar as absent and mark in the evidence comment the score was downgraded due to being insufficiently clear. The assumed rater/user knowledge level is a Master's student with some experience in code-based data analysis and a basic understanding of health-economic modelling. 
- The checklist is a living document and may change over time compared to the checklist and description provided in the manuscript. Prefer the current `CHECKLIST.md` rubric over any contradicting information provided in the manuscript. 
- For all items do not execute, install, compile, knit, or otherwise run any code from the downloaded repository. Read files as text/inspect their structure only. This applies regardless of how certain you are the code is safe, and regardless of what run instructions the repo provides — score what the repository *documents and contains*, not what you observe by actually running it.

### Step 5: Read the evidence comment format (apply to every item)

Use this structure, kept to one or two lines:

```
<path relative to repo root>[, section/line if useful]: <one factual observation>.
```

Rules: 

- Name the actual file/path/section the score is based on (e.g. `README.md#L1-20`, `scripts/run_model.R`, `no LICENSE file found at repository root or in subfolders`). A human should be able to go straight to that spot and confirm the evidence comment. 
- State what you observed, not an interpretation of quality. E.g. write "README.md lists R 4.2 but no lockfile found in repository root" rather than "documentation is somewhat weak."
- If multiple files/locations support the score, pick the single most decisive one for the main comment; only add a second clause if it changes the tier decision (e.g. "...; also no `install.packages()` calls documented anywhere"). 
- If an item could not be assessed with certainty, still fill in a rating using your best judgment, but set Certainty to `Low` and use the evidence comment to say what was missing or inaccessible and why (see "Flagging low-certainty items" below). 
- Do not use hedging language ("seems", "might", "probably") in the comment itself — hedging belongs in the Certainty column, not prose. 

### Step 6 - Read the certainty scoring rules

Set `certainty = Low` whenever any of the following applies, and name the specific reason in the evidence comment: 

- The repo is large/complex and only a partial static read was feasible in reasonable time — say what was and wasn't reviewed. 
- A referenced external resource (linked DOI, external wiki, Zenodo archive, separate data repository) could not be fetched. 
- Anything else that limits certainty: broken links, private sub-repos/submodules, ambiguous or contradictory documentation. 

Use `Medium` when the evidence is reasonably clear but based on a partial read, an inference, or a convention you're assuming the authors follow. 
Use `High` only when the file(s) you inspected directly and unambiguously support the tier chosen.

## Phase 2: Provide scores

Work through `MD1, MD2, MD3, MD4, MD5, CQ1, CQ2, CQ3, CQ4` using the corresponding scoring rules. For each of these nine items, record: 

- `rating` — the tier name in that item's own vocabulary: `Absent / Basic / Adequate / Advanced`. An item can instead be `Not assessable` if static evidence is genuinely insufficient to choose a tier (don't guess to avoid this value — see "Flagging low-certainty items" in scoring rules).
- `evidence_comment` — a few lines, following the required format (path + factual observation). 
- `certainty` — `High / Medium / Low`. 

Provide the scores in the following formats: 

1. A downloadable CSV file according to the template `rating_template.csv`. 
2. A list of each item of the checklist and for each item the following 3 sub-items: score, evidence comment and certainty score. 
3. Any comment to anything that you consider relevant but is not covered by this skill/instruction. 
