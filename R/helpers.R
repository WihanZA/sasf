#' Calculate aspect ratio and optimal dimensions for sf objects
#'
#' Calculates the aspect ratio of a simple features (sf) object and optionally
#' determines optimal plot dimensions based on a target width. For geographic
#' coordinates, also provides latitude-adjusted values.
#'
#' @param sf_obj An sf object with valid geometries
#' @param target_width Optional numeric value > 0 for desired plot width
#'
#' @return A list containing:
#'   \item{asp}{The raw aspect ratio (width/height) of the bounding box}
#'   \item{target_width}{The specified target width (if provided)}
#'   \item{target_height}{The calculated optimal height based on aspect ratio}
#'   \item{asp_adj}{Latitude-adjusted aspect ratio (for geographic coordinates)}
#'   \item{target_height_adj}{Adjusted optimal height (for geographic coordinates)}
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

  # Validate target_width if provided
  if (
    !is.null(target_width) && !is.numeric(target_width) && target_width <= 0
  ) {
    stop("target_width must be valid number > 0")
  }

  # Create empty response
  response <- list()

  # Get the bounding box
  bbox <- sf::st_bbox(sf_obj)

  # Calculate width and height
  bwidth <- bbox["xmax"] - bbox["xmin"]
  bheight <- bbox["ymax"] - bbox["ymin"]
  response$asp <- unname(bwidth / bheight)

  # Determine dimensions if valid target_width provided
  if (!is.null(target_width)) {
    response$target_width <- target_width
    response$target_height <- target_width / response$asp
  }

  # For geographic coordinates, adjust for latitude distortion
  if (sf::st_is_longlat(sf_obj)) {
    mean_lat <- (bbox["ymax"] + bbox["ymin"]) / 2
    bwidth_adj <- bwidth * cos(mean_lat * pi / 180)
    response$asp_adj <- unname(bwidth_adj / bheight)

    # provide adjusted target height
    if (!is.null(target_width)) {
      response$target_height_adj <- target_width / response$asp_adj
    }
  }

  # Return response
  return(response)
}
