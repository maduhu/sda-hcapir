#' HarvestChoice inventory of 5-arc-minute spatial indicators
#'
#' Metadata elements for HarvestChoice collection of 5-arc-minute rasters for
#' sub-Saharan Africa.
#'
#' @docType data
#' @keywords datasets
#' @name hcapi.catalog
#' @usage vi.R
#' @format data.table
#' @examples
#' # Catalog of metadata elements for all HarvestChoice indicators
#' names(hcapi.db)
#'
#' # Indicator codes and labels by category
#' hcapi.catalog[, .(varCode, varTitle), keyby=.(cat1, cat2, cat3)]
#'
#' # Print full metadata for cassava yield
#' as.list(hcapi.catalog["cass_y"])
#'
#' # Get specific metadata elements
#' hcapi.catalog[c("maiz_h", "cass_y"), .(varCode, varTitle, unit)]
#'
#' # Count of indicators by category
#' hcapi.catalog[, .N, keyby=.(cat1, cat2)]
NULL

#' List of ISO3 country and/or region codes
#'
#' List of ISO3 country codes and corresponding country/region labels.
#'
#' @docType data
#' @keywords datasets
#' @name hcapi.iso3
#' @usage iso.R
#' @format named character vector
#' @note Country boundaries are derived from FAO GAUL 2008 (2009 eds.)
#' @examples
#' # Lookup lists
#' hcapi.iso3
#'
NULL

#' HarvestChoice color palettes for mapping
#'
#' An (expanding) list of color palettes used to better symbolize HarvestChoice
#' indicators.
#'
#' @docType data
#' @keywords datasets
#' @name hcapi.pal
#' @usage pal.R
#' @format named character vector of HEX colors
#' @examples
#' #
NULL
