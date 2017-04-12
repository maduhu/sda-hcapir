---
title: "R Interface to HarvestChoice Data Services v3.0"
author: "Bacou, Melanie"
date: `r Sys.Date()`
output: html_document
---


# CELL5M: A Multidisciplinary Geospatial Database for Africa South of the Sahara

A set of convenience methods to interact with HarvestChoice Data Services v3. This data API porvides interactive access to HarvestChoice CELL5M, a geospatial database of biophysical, agricultural, and socio-economic indicators (at ) Access HarvestChoice 5-ac-minute (~10 sq. km.) gridded indicators for Africa South of the Sahara.

More about HarvestChoice spatial datasets at http://harvestchoice.org/data/. To explore HarvestChoice spatial layers in your browser visit [HarvestChoice MAPPR](http://apps.harvestchoice.org/mappr).

All HarvestChoice data retrieval methods are made available through a RESTful API (credits to [OpenCPU](http://github.com/jeroenooms/opencpu). HTTP POST requests may be sent using any REST-compatible client (e.g. cURL). Sample requests using cURL at the command line, in JavaScript, as well as in R +and STATA+ are available in the package documentation at http://harvestchoice.github.io/hc-api3. Documentation for each method may also be viewed at http://hcapi.harvestchoice.org/ocpu/library/hcapi3/man/{method-name}/html, e.g. http://hcapi.harvestchoice.org/ocpu/library/hcapi3/man/getLayer/html.

## Installation

```R
# Install HarvestChoice R package
devtools::install_github("harvestchoice/hc-api")
```

## Updates

Updates are posted to HarvestChoice Data Services at http://github.com/harvestchoice/hc-api3/CHANGES. This package only provides convenience methods to interact with HC Data Services in R.

