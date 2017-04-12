
.onLoad <- function(libname, pkgname) {
  options(
    na.last=T,
    hcapi.baseurl="http://hcapi.harvestchoice.org/"
    )
}