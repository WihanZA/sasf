
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `rsa.shapefiles`

<!-- badges: start -->

<!-- badges: end -->

The `rsa.shapefiles` package provides easy access to geographic
shapefiles with demarcations derived from South Africa’s Census 2011.
These shapefiles include various administrative levels such as
provinces, districts, municipalities, main places, and subplaces. The
package simplifies the process of loading and visualising spatial data
for South Africa.

The geographic codes in the `subplaces` data frame follow a hierarchical
structure consisting of multiple administrative levels. The
**municipality code** (`municipality_id`) is a three-digit identifier,
where the first digit represents the province and the next two are
unique to the municipality (e.g., `167` for Stellenbosch). The **main
place code** (`mainplace_id`) is a six-digit identifier, the first three
digits matching the municipality code and the last three uniquely
identifying the main place (e.g., `167007` for Franschhoek). Similarly,
the **subplace code** (`subplace_id`) is a nine-digit identifier, where
the first six correspond to the main place and the last three uniquely
identify the subplace (e.g., `167007001` for Wemmershoek).

## Installation

You can install the development version from this Github repository via
the [`remotes`](https://github.com/r-lib/remotes#readme) package in R.

``` r
# install.packages("remotes")
remotes::install_github("WihanZA/rsa.shapefiles")
```

## Examples

### Loading data

``` r
library(rsa.shapefiles)
subplaces <- rsa.shapefiles::subplaces
```

### Filter data

``` r
subplaces %>%
  filter(grepl("Stellenbosch", municipality_name)) %>%
  distinct(
    municipality_id, municipality_name,
    mainplace_id, mainplace_name,
    subplace_id, subplace_name
  ) %>%
  head()
## # A tibble: 6 × 6
##   municipality_id municipality_name mainplace_id mainplace_name subplace_id
##             <dbl> <chr>                    <dbl> <chr>                <dbl>
## 1             167 Stellenbosch            167007 Franschhoek      167007001
## 2             167 Stellenbosch            167015 Tennantville     167015001
## 3             167 Stellenbosch            167001 Klapmuts         167001001
## 4             167 Stellenbosch            167001 Klapmuts         167001002
## 5             167 Stellenbosch            167001 Klapmuts         167001003
## 6             167 Stellenbosch            167001 Klapmuts         167001004
## # ℹ 1 more variable: subplace_name <chr>
```

### Plotting data

``` r
library(ggplot2)

ggplot() +
  theme_void() +
  geom_sf(data = subplaces, color = "grey50")
```

<img src="man/figures/README-plotting-1.png" width="100%" />

### Aggregating data with `st_union`

``` r
library(sf)

provinces <- subplaces %>%
  group_by(province_id) %>%
  summarise(
    geometry = st_union(geometry),
    .groups = "drop"
  )

ggplot() +
  theme_void() +
  # use province borders
  geom_sf(
    data = provinces,
    color = "white",
    fill = NA,
    linewidth = 0.25
  ) +
  # use subplace fill
  geom_sf(
    data = subplaces,
    aes(fill = stringr::str_sub(subplace_id, 6, 9)),
    color = NA,
    show.legend = FALSE
  ) +
  scale_fill_viridis_d(option = "magma", begin = 0.15)
```

<img src="man/figures/README-aggregating-1.png" width="100%" />

# Acknowledgements

- The definitions and demarcations used in Census 2011 are detailed in
  the **[Census 2011
  Metadata](https://www.statssa.gov.za/census/census_2011/census_products/Census_2011_Metadata.pdf)**,
  published by Statistics South Africa (2012). The document provides
  comprehensive information on the geographical boundaries, coding
  structures, and methodologies used for the census.

- This wiki by [konektaz](https://github.com/konektaz) provdides a
  useful summary of the hierarchical structure of spatial layers: [South
  Africa Census 2011 spatial
  metadata](https://github.com/konektaz/shape-files/wiki/South-Africa---Census-2011-spatial-metadata)

- The original shapefiles were sourced from the [OpenUp Data
  Portal](https://data.openup.org.za/) at this link: [Census 2011
  Boundaries Subplace
  Layer](https://data.openup.org.za/dataset/census-2011-boundaries-subplace-layer-qapr-gczi/)
