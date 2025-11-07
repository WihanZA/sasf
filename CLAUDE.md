# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`sasf` is an R package that provides simplified access to South African spatial data (shapefiles) based on 2011 Census demarcations. The package includes geographic units at various administrative levels: provinces, districts, municipalities, mainplaces, and subplaces.

## Development Commands

### Package Building and Checking
```r
# Core development workflow
devtools::document()  # Update documentation
devtools::check()     # Check package for errors
devtools::install()   # Install the package locally
```

### Code Formatting
The package uses `air` for R code formatting with configuration in `air.toml`:
- Line width: 80 characters
- Indent: 2 spaces
- Persistent line breaks enabled

## Architecture and Structure

### Core Components
- **Main dataset**: `subplaces` - A simplified sf object containing 22,108 subplaces with hierarchical administrative data
- **Helper function**: `get_asp()` - Calculates aspect ratios for sf objects to prevent whitespace in plots
- **Data processing**: Raw shapefiles are cleaned, simplified, and compressed using `rmapshaper::ms_simplify()`

### Key Files
- `R/subplaces.R` - Documentation for the main subplaces dataset
- `R/helpers.R` - Contains the `get_asp()` function for aspect ratio calculations
- `data-raw/subplaces.R` - Data processing pipeline that creates the package dataset
- `scripts/config-package.R` - Package setup and configuration script

### Data Management
- Large datasets use Git LFS (configured in `.gitattributes`)
- Lazy loading enabled for memory efficiency
- Dataset compressed using XZ compression
- Original dataset simplified to retain ~20% of vertices for performance

### Geographic Hierarchy
The spatial data follows South African Census 2011 hierarchy:
1. Province (9 total)
2. District Municipality (52 total) 
3. Local Municipality (234 total)
4. Main Place (14,039 total)
5. Subplace (22,108 total)

### Dependencies
- **Core**: `sf` package for spatial data handling
- **Development**: `devtools`, `usethis`, `roxygen2` for package development
- **Data processing**: `dplyr`, `tidyr`, `janitor`, `rmapshaper` for data manipulation

## Testing
Package uses `testthat` (edition 3) but no test files currently exist in the repository.