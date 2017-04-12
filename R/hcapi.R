#' Subset, summarize, and download HarvestChoice 5-arc-minute spatial indicators for
#' Africa South of the Sahara
#'
#' Wrapper method to subset, aggregate, plot, and/or summarize  HarvestChoice indicators.
#' This method can also be used to summarize categorical variables across
#' continuous variables (e.g. to identify dominant agro-ecological zones across zones
#' of low and high body-mass index \code{hcapi("AEZ16_CLAS", by="bmi")}). Here
#' \code{AEZ16_CLAS} is a categorical variable, and \code{bmi} is a continuous
#' variable, but the request is valid. The dominant class of \code{AEZ16_CLAS} is
#' returned along intervals of \code{bmi}. Default intervals are used, but custom
#' intervals may also be passed as arguments in a list, e.g.
#' \code{hcapi("AEZ16_CLAS", by=list(bmi=c(0,5,10,15,20,25)))}.
#' Indicators may also be summarized (extracted) over spatial points or customs areas
#' passed as valid WKT representations using \code{wkt} argument.
#' Use \code{format} argument to control the output format (see valid formats below).
#'
#' @param x character array of HarvestChoice indicators. Use \code{\link{hcapi_db}}
#' to query the list of indicators and additional metadata (e.g. units, reference year,
#' sources, etc.)
#' @param iso3 optional character array of ISO3 country or region codes. Use
#'   \code{\link{hcapi.iso3}} to see a list of available countries and codes. Default
#'   is to return data for all countries in sub-Saharan Africa.
#' @param by optional character array of HarvestChoice indicators (codes) to summarize by.
#' @param format output format, one of "data.table", "list", "csv", "tif", "dta", "asc",
#' "grd", "rds", else "plot" to plot the rasters, or "hist" to plot histogram and
#'   univariate statistics.
#' @param wkt WKT representation of a spatial object (points, multipoints, or
#'   polygons, multipolygons) for which to summarize \code{x} indicators.
#' @param ... other optional arguments passed to specific API methods, e.g.
#' \code{collapse}, \code{dir}. For more details refer to the full API documentation at
#' \url{http://harvestchoice.github.io/hc-api3/}.
#' @return a data.table (or other file formats) of \code{x} indicators summarized across
#'   \code{by} spatial domain(s) or custom \code{wkt} points/areas.
#' @seealso \code{\link{plot.hcapi}}, \code{\link{print.hcapi}}, \code{\link{hist.hcapi}}
#' @examples
#' # Mean body mass index and cassava yield across provinces and districts of Tanzania
#' # and Ghana
#' x <- hcapi(
#'   c("bmi", "cass_y"), iso3=c("GHA", "TZA"),
#'   by=c("ADM1_NAME_ALT", "ADM2_NAME_ALT"))
#'
#' # Plot results for Mara province in Tanzania
#' require(lattice)
#' barchart(ADM2_NAME_ALT~bmi, data=x[ADM1_NAME_ALT=="Mara"], col="grey90")
#'
#' # Mean cassava yield in Ivory Coast in raster format
#' x <- hcapi("cass_y", iso3="CIV", format="grd")
#' plot(brick(x))
#'
#' # The method may be expanded to summarize classified (discrete) variables along continuous
#' # variables. For example the call below returns the dominant agro-ecological zone and
#' # average stunting in children under 5 over Ethiopia's provinces by elevation class
#' hcapi(
#'   varc("AEZ8_CLAS", "stunted_moderate"),
#'   iso3="ETH",
#'   by=c("ADM1_NAME_ALT", "ELEVATION"))
#'
#' # Mean harvested maize area summarized across a custom polygon. HarvestChoice API
#' # takes argument \code{wkt} (a valid WKT representation) to summarize indicator(s)
#' # over a user-specified area.
#' hcapi(
#'   "maiz_h",
#'   wkt="POLYGON((-16.35819663578485006 15.36599264077935345,
#'     -15.42501860768386379 15.69472580976947462, -15.11749403024149174 14.83577785208561117,
#'     -16.13550642453347805 14.68731771125136376, -16.35819663578485006 15.36599264077935345))")
#'
#' @export
hcapi <- function(x, iso3="SSA", by=NULL, format=NULL, ...) {

  x <- match.arg(x, hcapi.catalog$varCode, several.ok=TRUE)
  by <- match.arg(x, hcapi.catalog$varCode, several.ok=TRUE)
  iso3 <- match.arg(iso3, hcapi.iso3, several.ok=TRUE)
  format <- match.arg(format,
    c("csv", "tif", "dta", "asc", "grd", "rds"))

  ua <- user_agent("http://github.com/harvestchoice/hc-api")
  hdl <- handle(getOption("hcapi.baseurl"))

  # Ping API
  resp <- POST(
    handle=hdl,
    path="ocpu/library/hcapi3/R/hcapi",
    body=list(var=x, iso3=iso3, by=by, format=format, ...),
    encode="json")

  # Validate JSON response
  if (http_error(resp)==TRUE) stop(
    "API did not return any valid JSON response",
    call.=FALSE)

  # Return response content using session token
  format <- ifelse(missing(format), "json", format)
  resp <- switch(format,
    # ZIP data package
    zip  = GET(
      handle=hdl,
      path=paste0("ocpu/tmp/", headers(resp)$`x-ocpu-session`, "/zip")),

    # PNG plot(s)
    plot  = GET(
      handle=hdl,
      path=paste0("ocpu/tmp/", headers(resp)$`x-ocpu-session`, "/graphics/last/png")),

    # Simple JSON
    json = GET(
      handle=hdl,
      path=paste0("ocpu/tmp/", headers(resp)$`x-ocpu-session`, "/R/.val/json"),
      query=list(dataframe="columns"))
  )

  if (status_code(resp) != 200) stop(sprintf(
    "API request failed [%s]\n%s\n<%s>",
    status_code(resp),
    out$message,
    out$documentation_url
  ), call.=FALSE)

  # Parse out
  out <- fromJSON(content(resp, as="text", encoding="UTF-8"))
  structure(list(content=out, response=resp), class="hcapi")

}

#' Explore HarvestChoice indicator in MAPPR interactive application
view.hcapi <- function(x) {}


#' Print information on HarvestChoice indicators
print.hcapi <- function(x, ...) {
  cat("<GitHub ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}


#' Plot HarvestChoice indicators as rasters
plot.hcapi <- function(x, ...) {
}




