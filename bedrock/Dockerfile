FROM debian:stable-slim as builder
ARG ETOPO_GRIDFILE
ARG ETOPO_SURFACE
RUN apt update && \
        apt install -y -q --no-install-recommends \
        gzip ca-certificates && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /bedrock

# fetch and unzip ETOPO Grid file
ADD https://ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/${ETOPO_SURFACE}/grid_registered/netcdf/${ETOPO_GRIDFILE}.gz /bedrock/${ETOPO_GRIDFILE}.gz
RUN gunzip /bedrock/${ETOPO_GRIDFILE}.gz

FROM debian:stable-slim
ARG ETOPO_GRIDFILE
RUN export DEBIAN_FRONTEND=noninteractive && \
        apt update && \
        apt install -y -q --no-install-recommends \
        gmt gmt-gshhg-high ghostscript && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

RUN gmt --version

COPY --from=builder /bedrock/${ETOPO_GRIDFILE} /bedrock/${ETOPO_GRIDFILE}

CMD echo ${ETOPO_GRIDFILE}!
