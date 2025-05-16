#' Subplaces Dataset
#'
#' The `subplaces` dataset contains spatial data for subplaces in South Africa
#' based on the 2011 Census. This dataset includes various geographic and
#' administrative attributes for each subplace.
#'
#' @format
#' A spatial data frame (sf object) with 22,108 rows and 17 variables.
#' Geodetic CRS: WGS84(DD)
#' Class: sf/tbl_df/tbl/data.frame
#' \describe{
#'   \item{subplace_id}{Character. Subplace code.}
#'   \item{subplace_name}{Character. Name of the subplace.}
#'   \item{mainplace_id}{Character. Main place code.}
#'   \item{mainplace_name}{Character. Name of the main place.}
#'   \item{municipality_id}{Character. Local municipality code.}
#'   \item{municipality_name}{Character. Name of the local municipality.}
#'   \item{municipality_mdb}{Character. Local municipality MDB code.}
#'   \item{district_id}{Character. District municipality code.}
#'   \item{district_name}{Character. Name of the district municipality.}
#'   \item{district_mdb}{Character. District municipality MDB code.}
#'   \item{province_id}{Character. Province code.}
#'   \item{province_name}{Character. Name of the province.}
#'   \item{province_mdb}{Character. Province MDB code.}
#'   \item{shape_albers}{Numeric. Albers Equal Area projection.}
#'   \item{shape_area}{Numeric. Shape area.}
#'   \item{shape_length}{Numeric. Shape length.}
#'   \item{geometry}{sfc_MULTIPOLYGON.
#' The `sfc` list-column containing the `sfg` multipolygon
#' geometry for each subplace.}
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
#' @note MDB refers to the Municipal Demarcation Board of South Africa.
#'
"subplaces"
