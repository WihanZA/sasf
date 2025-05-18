##' Calculate aspect ratio and optimal dimensions for sf objects
#'
#' Calculates the aspect ratio of a simple features (sf) object and optionally
#' determines optimal plot dimensions based on a target width. For geographic
#' coordinates, the aspect ratio is adjusted for latitude distortion.
#'
#' @param sf_obj An sf object with valid geometries
#' @param target_width Optional numeric value > 0 for desired plot width
#'
#' @return A list containing:
#'   \item{asp}{The aspect ratio (width/height) of the bounding box, adjusted for latitude in geographic coordinates}
#'   \item{target_width}{The specified target width (if provided)}
#'   \item{target_height}{The calculated optimal height based on aspect ratio}
#'
#' @author Wihan Marais <github.com/WihanZA>
#'
#' @importFrom sf st_bbox st_is_longlat
#' @export

get_asp <- function(sf_obj, target_width = NULL) {
  # Validate sf_obj
  if (!inherits(sf_obj, "sf")) {
    stop("sf_obj must be valid sf object")
  }

  # Create empty response
  response <- list()

  # Validate target_width if provided
  if (
    !(!is.null(target_width) && is.numeric(target_width) && target_width > 0)
  ) {
    stop("target_width must be valid number > 0")
  }

  # Get the bounding box
  bbox <- sf::st_bbox(sf_obj)

  # Calculate width and height
  bwidth <- bbox["xmax"] - bbox["xmin"]
  bheight <- bbox["ymax"] - bbox["ymin"]

  # For geographic coordinates, adjust for latitude distortion
  if (sf::st_is_longlat(sf_obj)) {
    mean_lat <- (bbox["ymax"] + bbox["ymin"]) / 2
    bwidth <- bwidth * cos(mean_lat * pi / 180)
  }

  response$asp <- unname(bwidth / bheight)

  # Determine target dimensions
  if (!is.null(target_width)) {
    response$target_width <- target_width
    response$target_height <- target_width / response$asp
  }

  # Return response
  return(response)
}
