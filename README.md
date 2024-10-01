
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `rsa.shapefiles`

<!-- badges: start -->

<!-- badges: end -->

This package simplifies the process of loading and visualising spatial
data for South Africa in `R`. Shapefiles encompass various
administrative levels, such as provinces, districts, municipalities,
main places, and subplaces, using Census 2011 demarcations.

The main dataset of interest `subplaces` data frame is embedded in the
package. `_id` columns represent unique numeric identifiers, while
`_name` columns provide descriptive names. `_mdb` columns present string
identifiers corresponding to the demarcations of the Municipal
Demarcation Board of South Africa for provinces, districts, and
municipalities.

`subplaces` is structured hierarchically on the basis of `_id` values,
with the exception of districts. Consider, for example, the subplace
“Wemmershoek”:

- `subplace_id`: 167007001
- `mainplace_id`: 167007
- `municipality_id`: 167
- `province_id`: 1

## Installation

This package requires a working installation of
[sf](https://github.com/r-spatial/sf#installing).

You can install the development version from this Github repository via
the [`remotes`](https://github.com/r-lib/remotes#readme) package in R.

``` r
# install.packages("remotes")
# install.packages("sf")
remotes::install_github("WihanZA/rsa.shapefiles")
library(rsa.shapefiles)
library(sf)
```

## Examples

### Loading and filtering data

``` r
rsa.shapefiles::subplaces %>%
  filter(grepl("Stellenbosch", municipality_name)) %>%
  distinct(
    mainplace_name,
    subplace_name
  ) %>%
  head()
## # A tibble: 6 × 2
##   mainplace_name subplace_name  
##   <chr>          <chr>          
## 1 Franschhoek    Wemmershoek    
## 2 Tennantville   Tennantville SP
## 3 Klapmuts       Bennetsville   
## 4 Klapmuts       Klapmuts SP    
## 5 Klapmuts       Weltevrede Park
## 6 Klapmuts       Mandela City
```

### Plotting data

``` r
library(ggplot2)

ggplot() +
  theme_void() +
  geom_sf(data = subplaces, color = "grey50")
```

<img src="man/figures/README-plotting-1.png" width="50%" />

### Aggregating data with `st_union`

``` r
# From subplaces to provinces
provinces <- subplaces %>%
  group_by(province_id) %>%
  summarise(
    geometry = st_union(geometry),
    .groups = "drop"
  )
```

But `st_union` may take a long time to run, so you can use the
pre-aggregated `provinces` data frame instead, as in the example below.

``` r
ggplot() +
  theme_void() +
  # use subplace fill
  geom_sf(
    data = subplaces,
    aes(fill = stringr::str_sub(subplace_id, 6, 9)),
    color = NA,
    show.legend = FALSE
  ) +
  # use province borders
  geom_sf(
    data = rsa.shapefiles::provinces,
    color = "white",
    fill = NA,
    linewidth = 1
  ) +
  scale_fill_viridis_d(option = "magma", begin = 0.15)
```

<img src="man/figures/README-aggregatingplot-1.png" width="50%" />

# Acknowledgements

- The definitions and demarcations used in Census 2011 are detailed in
  the corresponding
  **[metadata](https://www.statssa.gov.za/census/census_2011/census_products/Census_2011_Metadata.pdf)**,
  published by Statistics South Africa (2012).

- The wiki by [konektaz](https://github.com/konektaz) offers a useful
  summary of the hierarchical structure of spatial layers: *[South
  Africa Census 2011 spatial
  metadata](https://github.com/konektaz/shape-files/wiki/South-Africa---Census-2011-spatial-metadata)*

- The original shapefiles were sourced from the [OpenUp Data
  Portal](https://data.openup.org.za/) at this link: *[Census 2011
  Boundaries Subplace
  Layer](https://data.openup.org.za/dataset/census-2011-boundaries-subplace-layer-qapr-gczi/)*
