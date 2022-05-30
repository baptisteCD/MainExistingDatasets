# Author: Etienne CAMENEN
# Date: 2022
# Contact: etienne.camenen@gmail.com

FROM rocker/shiny-verse

MAINTAINER Etienne CAMENEN (etienne.camenen@gmail.com)

ENV PKGS cmake git libcurl4-openssl-dev libgdal-dev liblapack-dev libproj-dev libssl-dev libudunits2-dev libxml2-dev qpdf
ENV _R_CHECK_FORCE_SUGGESTS_ FALSE
ENV TOOL_NAME MainExistingDatasets
ENV TOOL_VERSION 0.1.0

RUN apt-get update --allow-releaseinfo-change -qq && \
   apt-get install -y ${PKGS}

RUN mkdir /usr/app
COPY . /usr/app

RUN R -e 'dep <- desc::desc_get_deps("./usr/app/DESCRIPTION"); install.packages(dep[dep$type == "Imports", ]$package)'
RUN cd /usr/app  && \
    R -e "devtools::install(upgrade = 'never')"

RUN chown -R shiny usr/app/
USER shiny

EXPOSE 3838

CMD ["R", "-e", "MainExistingDatasets::run_app(option = list(host = '0.0.0.0', port = 3838))"]