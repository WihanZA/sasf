#' Subplaces Dataset
#'
#' The `subplaces` dataset contains spatial data for subplaces in South Africa
#' based on the 2011 Census. This dataset includes various geographic and
#' administrative attributes for each subplace.
#'
# ` @format ## `subplaces`
# ` A data frame with 22,108 rows and 17 columns:
#' \describe{
#'   \item{province_id}{Province code.}
#'   \item{province_mdb}{Province MDB code.}
#'   \item{province_name}{Name of the province.}
#'   \item{district_id}{District municipality code.}
#'   \item{district_mdb}{District municipality MDB code.}
#'   \item{district_name}{Name of the district municipality.}
#'   \item{municipality_id}{Local municipality code.}
#'   \item{municipality_mdb}{Local municipality MDB code.}
#'   \item{municipality_name}{Name of the local municipality.}
#'   \item{mainplace_id}{Main place code.}
#'   \item{mainplace_name}{Name of the main place.}
#'   \item{subplace_id}{Subplace code.}
#'   \item{subplace_name}{Name of the subplace.}
#'   \item{albers_area}{Area in Albers projection.}
#'   \item{shape_area}{Shape area.}
#'   \item{shape_length}{Shape length.}
#'   \item{geometry}{The `sf` multipolygon for subplace.}
#' }
#'
#'
#' Note: MDB refers to the Municipal Demarcation Board of South Africa.
#'
#' @source \url{https://github.com/konektaz/shape-files/wiki/South-Africa---Census-2011-spatial-metadata}
#' @source \url{https://github.com/konektaz/shape-files/tree/master}
#' @source \url{https://data.openup.org.za/dataset/census-2011-boundaries-subplace-layer-qapr-gczi/resource/1d0ad274-620f-4b1b-982f-646a2172a313}
"subplaces"
