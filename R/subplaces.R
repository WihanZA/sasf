#' Subplaces Dataset (Simplified)
#'
#' The `subplaces` dataset contains spatial
#'  data for subplaces in South Africa based on the 2011 Census demarcations.
#' The dataset keeps approximately 20% of source data's original vertices,
#' making it more suitable for visualisation
#' and analysis that don't require high-resolution boundaries.
#' This dataset includes various geographic and
#' administrative attributes for each subplace with detailed geometries.
#'
#' @format
#' A spatial data frame (sf object) with 22,108 rows and 17 variables.
#' Geodetic CRS: WGS84(DD)
#' Class: sf/tbl_df/tbl/data.frame
#' \describe{
#'   \item{subplace_id}{Character.
#' Unique identifier for each subplace as designated in the 2011 Census.}
#'   \item{subplace_name}{Character.
#' Official name of the subplace as defined by Statistics South Africa.}
#'   \item{mainplace_id}{Character.
#' Unique identifier for the main place that contains this subplace.}
#'   \item{mainplace_name}{Character.
#' Official name of the main place that contains this subplace.}
#'   \item{municipality_id}{Character.
#' Unique identifier for the local municipality containing this subplace.}
#'   \item{municipality_name}{Character.
#' Official name of the local municipality.}
#'   \item{municipality_mdb}{Character.
#' Municipal Demarcation Board code for the local municipality.}
#'   \item{district_id}{Character.
#' Unique identifier for the district municipality.}
#'   \item{district_name}{Character.
#' Official name of the district municipality.}
#'   \item{district_mdb}{Character.
#' Municipal Demarcation Board code for the district municipality.}
#'   \item{province_id}{Character.
#' Unique identifier for the province containing this subplace.}
#'   \item{province_name}{Character.
#' Official name of the province (e.g., Gauteng, Western Cape).}
#'   \item{province_mdb}{Character.
#' Municipal Demarcation Board code for the province.}
#'   \item{shape_albers}{Numeric.
#' Area in square meters using the Albers Equal Area projection.}
#'   \item{shape_area}{Numeric.
#' Area of the subplace polygon in square meters.}
#'   \item{shape_length}{Numeric.
#' Perimeter of the subplace polygon in meters.}
#'   \item{geometry}{sfc_MULTIPOLYGON.
#' The `sfc` list-column containing the simplified `sfg`
#' multipolygon geometry for each subplace,
#' defining its boundaries using the WGS84 coordinate reference system.}
#' }
#'
#' @section Geographic Hierarchy:
#' South African Census 2011 geography
#' follows this hierarchy (from largest to smallest):
#' \itemize{
#'   \item Province
#'   \item District Municipality
#'   \item Local Municipality
#'   \item Main Place
#'   \item Subplace
#' }
#'
#' @source
#' * Edzer Pebesma, 2018. Simple Features for R: Standardized Support
#' for Spatial Vector Data. The R Journal 10:1, 439-446.
#' * \url{https://data.openup.org.za/dataset/
#' census-2011-boundaries-subplace-layer-qapr-gczi/resource/
#' 1d0ad274-620f-4b1b-982f-646a2172a313}
#' * \url{https://github.com/konektaz/shape-files/wiki/
#' South-Africa---Census-2011-spatial-metadata}
#'
#' @note
#' MDB refers to the Municipal Demarcation Board of South Africa.
#' This dataset is a simplified and cleaned version of its source data,
#' created using `rmapshaper::ms_simplify()` with `keep = 0.2` to
#' retain approximately 20% of the original vertices.
#' This reduces the file size to approximately 11 MB on disk
#' and 46 MB in memory, making it more manageable for visualization
#' and analysis that don't require high-resolution boundaries.
#'
"subplaces"
