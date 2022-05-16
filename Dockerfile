# Author: Etienne CAMENEN
# Date: 2022
# Contact: etienne.camenen@gmail.com

FROM rocker/rstudio

MAINTAINER Etienne CAMENEN (etienne.camenen@gmail.com)

ENV PKGS cmake git libcurl4-openssl-dev libgdal-dev liblapack-dev libproj-dev libssl-dev libudunits2-dev libxml2-dev qpdf
ENV _R_CHECK_FORCE_SUGGESTS_ FALSE

RUN apt-get update -qq && \
    apt-get install -y ${PKGS}

ENV RPKGS attachment BiocManager config covr data.table devtools dplyr DT globals ggplot2 ggpubr golem htmlwidgets knitr leaflet lintr markdown openxlsx pkgload plotly readr reactlog reshape2 rmarkdown rnaturalearth rsconnect rstatix shinytest testthat sf shiny spData styler tmap
RUN Rscript -e 'install.packages(commandArgs(TRUE))' ${RPKGS}

RUN Rscript -e 'BiocManager::install("BiocCheck")'
RUN cd /home/rstudio/ && \
    Rscript -e 'shinytest::installDependencies()'
RUN apt-get install -y --no-install-recommends libxt6
COPY . /home/rstudio
