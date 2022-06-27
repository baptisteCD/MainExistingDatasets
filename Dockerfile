# Author: Etienne CAMENEN
# Date: 2022
# Contact: etienne.camenen@gmail.com

FROM rocker/shiny-verse

MAINTAINER Etienne CAMENEN (etienne.camenen@gmail.com)

ENV PKGS cmake git libcurl4-openssl-dev libgdal-dev liblapack-dev libproj-dev libssl-dev libudunits2-dev libxml2-dev qpdf
ENV _R_CHECK_FORCE_SUGGESTS_ FALSE
ENV TOOL_NAME MainExistingDatasets
ENV TOOL_VERSION 0.3.0

RUN apt-get update --allow-releaseinfo-change -qq && \
    apt-get install -y ${PKGS}
RUN R -e "devtools::install_github('baptisteCD/"${TOOL_NAME}"', ref = '"${TOOL_VERSION}"')"
RUN apt-get purge -y git g++ && \
	apt-get autoremove --purge -y && \
	apt-get clean && \
	rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

EXPOSE 3838

CMD ["R", "-e", "MainExistingDatasets::run_app(option = list(host = '0.0.0.0', port = 3838))"]