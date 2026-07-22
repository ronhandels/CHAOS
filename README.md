# CHecklist for Assessing Open Source Health Economic Models (CHAOS)

This repository contains a checklist aimed at rating the documentation quality of open-source health-economic models. The checklist is designed as a rubric with several categories with multiple items each scored on a 4-point scale. 

Detailed information on its background and applications: 

- https://opensourcemodelgroup.wordpress.com/2026/03/06/open-source-model-quality-checklist/
- [placeholder manuscript]

## Repository overview

- CHECKLIST.md : This file contains the checklist including rubric rating details. 
- scripts/R/ : This folder contains a script to read the checklist and create ratings. 

## Installation guidance

To use the scripts follow these steps:

- Download files: download the files from this repository (click green 'code' button, 'download ZIP' and unzip files to disk) or clone repository. 
- Install R: install R by following the instruction here: https://cran.r-project.org/. Scripts were developed and tested using R version 4.6.1. 
- Install Rstudio (optional): Install RStudio by following the instructions here: https://posit.co/downloads. 
- Open `CHAOS.Rproj` in RStudio. 
- Install packages: not needed as no packages are used in the scripts. 

## Use guidance

- The checklist can be used manually according to instructions provided in the background information [placeholder manuscript]. We recommend including a copy of the rubric next to its version number to ensure transparency which version/phrasing has been used. 
- The checklist can be converted to an R data frame by running the script `read_checklist.R`. 

## Feedback and support

### Proposing a change to the checklist

We welcome suggestions for improving the checklist. Open a pull request to propose new items, rephrase items, clarify guidance or other. 

1. Edit `CHECKLIST.md`.
2. Keep `item_id` values stable to ensure any existing applications of the checklist reference to the same items. Give new items a new, previously-unused ID.
3. Open a pull request. Checklist changes affect every future (and arguably every past) rating, so these are reviewed by a maintainer before merging.

### Contact details

For contact details, see: https://www.maastrichtuniversity.nl/r-handels

## Version history

### v1.0.0 (release pending)

This first version aligns with the checklist presented in the manuscript describing the development and validation of the checklist [DOI placeholder manuscript]. 

## Citation

The checklist and this repository can be referred to by citing by the manuscript describing its development: 

[placeholder citation including DOI]

## Related projects

[placeholder]

## License

This project is licensed under Creative Commons Attribution 4.0 International (see file README.md). 

## Acknowledgment

- Ron Handels (background and contact details: https://www.maastrichtuniversity.nl/r-handels)
- Matthew Carroll
- Ian Cromwell
- Talitha Feenstra
- Jinjing Fu
- Raymond Henderson
- Sam Hirniak
- Eline Krijkamp
- Robert Smith
- Xavier G.L.V. Pouwels

We thank several members among the health-economic modeling community for providing comments and suggestions which helped us develop and improve the checklist. 

