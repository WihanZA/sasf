Wihan Marais
2025-05-16

- [`sasf`](#sasf)
  - [Installation](#installation)
  - [Basics](#basics)
- [Acknowledgements](#acknowledgements)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# `sasf`

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/sasf)](https://CRAN.R-project.org/package=sasf)
<!-- badges: end -->

The goal of `sasf` is to simplify the process of loading and visualising
spatial data for South Africa in `R`. Shapefiles encompass various
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

<!-- This package requires a working installation of [`sf`](https://github.com/r-spatial/sf#installing). -->

You can install the development version of `sasf` from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("WihanZA/sasf")
```

## Basics

``` r
# lazy loading of data
lobstr::mem_used()
```

    #> 72.20 MB

``` r
library(sasf)
lobstr::mem_used()
```

    #> 72.52 MB

``` r
invisible(subplaces)
lobstr::mem_used()
```

    #> 115.62 MB

``` r
# geographic hierarchy
subplaces %>%
  # exclude sfc geometry column
  as.data.frame() %>%
  select(ends_with("_id")) %>%
  pivot_longer(everything()) %>%
  group_by(name) %>%
  summarise(n = n_distinct(value)) %>%
  arrange(desc(n))
```

    #> # A tibble: 5 × 2
    #>   name                n
    #>   <chr>           <int>
    #> 1 subplace_id     22108
    #> 2 mainplace_id    14039
    #> 3 municipality_id   234
    #> 4 district_id        52
    #> 5 province_id         9

``` r
# filtering
subplaces %>%
  filter(grepl("stellenbosch", municipality_name, ignore.case = TRUE)) %>%
  head()
```

    #> Simple feature collection with 6 features and 16 fields
    #> Geometry type: POLYGON
    #> Dimension:     XY
    #> Bounding box:  xmin: 18.85507 ymin: -33.92334 xmax: 19.05194 ymax: -33.80165
    #> Geodetic CRS:  WGS84(DD)
    #> # A tibble: 6 × 17
    #>   district_id municipality_name municipality_id province_name mainplace_name
    #>   <chr>       <chr>             <chr>           <chr>         <chr>         
    #> 1 102         Stellenbosch      167             Western Cape  Franschhoek   
    #> 2 102         Stellenbosch      167             Western Cape  Tennantville  
    #> 3 102         Stellenbosch      167             Western Cape  Klapmuts      
    #> 4 102         Stellenbosch      167             Western Cape  Klapmuts      
    #> 5 102         Stellenbosch      167             Western Cape  Klapmuts      
    #> 6 102         Stellenbosch      167             Western Cape  Klapmuts      
    #> # ℹ 12 more variables: province_id <chr>, province_mdb <chr>,
    #> #   district_name <chr>, municipality_mdb <chr>, district_mdb <chr>,
    #> #   mainplace_id <chr>, subplace_name <chr>, subplace_id <chr>,
    #> #   shape_albers <dbl>, shape_length <dbl>, shape_area <dbl>,
    #> #   geometry <POLYGON [°]>

``` r
# plotting
subplaces %>%
  filter(grepl("stellenbosch", municipality_name, ignore.case = TRUE)) %>%
  ggplot() +
  theme_void() +
  geom_sf(
    aes(fill = subplace_id),
    color = "grey50",
    show.legend = FALSE
  )
```

<img src="man/figures/README-basics-1.png" width="50%" style="display: block; margin: auto;" />

### Aggregating data with `st_union`

``` r
# From subplaces to provinces
provinces <- sasf::subplaces %>%
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
    data = sasf::subplaces,
    aes(fill = stringr::str_sub(subplace_id, 6, 9)),
    color = NA,
    show.legend = FALSE
  ) +
  # use province borders
  geom_sf(
    data = sasf::provinces,
    color = "white",
    fill = NA,
    linewidth = 1
  ) +
  scale_fill_viridis_d(option = "magma", begin = 0.15)
```

# Acknowledgements

- The definitions and demarcations used in Census 2011 are detailed in
  the corresponding
  *[metadata](https://www.statssa.gov.za/census/census_2011/census_products/Census_2011_Metadata.pdf)*,
  published by Statistics South Africa (2012).

- The wiki by [konektaz](https://github.com/konektaz) offers a useful
  summary of the hierarchical structure of spatial layers: *[South
  Africa Census 2011 spatial
  metadata](https://github.com/konektaz/shape-files/wiki/South-Africa---Census-2011-spatial-metadata)*

- The original shapefiles were sourced from the [OpenUp Data
  Portal](https://data.openup.org.za/) at this link: *[Census 2011
  Boundaries Subplace
  Layer](https://data.openup.org.za/dataset/census-2011-boundaries-subplace-layer-qapr-gczi/)*
