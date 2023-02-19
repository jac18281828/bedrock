FROM debian:stable-slim as builder
ARG ETOPO_GRIDFILE
ARG ETOPO_SURFACE
ARG ETOPO_RES
RUN apt update && \
        apt install -y -q --no-install-recommends \
        gzip ca-certificates && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /bedrock

# 2022 GEOTIFF elevation
# https://www.ngdc.noaa.gov/mgg/global/relief/ETOPO2022/data/30s/30s_bed_elev_gtif/ETOPO_2022_v1_30s_N90W180_bed.tif

# 2022 netcdf
# https://www.ngdc.noaa.gov/thredds/fileServer/global/ETOPO2022/30s/30s_bed_elev_netcdf/ETOPO_2022_v1_30s_N90W180_bed.nc

ADD https://www.ngdc.noaa.gov/thredds/fileServer/global/ETOPO2022/${ETOPO_RES}/${ETOPO_RES}_${ETOPO_SURFACE}_elev_netcdf/ETOPO_2022_v1_${ETOPO_RES}_N90W180_${ETOPO_SURFACE}.nc /bedrock/${ETOPO_GRIDFILE}

FROM debian:stable-slim
ARG ETOPO_GRIDFILE
RUN export DEBIAN_FRONTEND=noninteractive && \
        apt update && \
        apt install -y -q --no-install-recommends \
        gmt gmt-gshhg-high ghostscript python3 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

RUN gmt --version

COPY --from=builder /bedrock/${ETOPO_GRIDFILE} /bedrock/${ETOPO_GRIDFILE}

WORKDIR /bedrock
COPY . .
RUN python3 sha3sum.py /bedrock/${ETOPO_GRIDFILE} > /bedrock/${ETOPO_GRIDFILE}.sha3
RUN VERIFICATION=$(cat /bedrock/${ETOPO_GRIDFILE}.sha3) && echo "${ETOPO_GRIDFILE} sha3 is ${VERIFICATION}"

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="bedrock" \
    org.label-schema.description="GMT6 and ETOPO1 Ice or Bedrock Container" \
    org.label-schema.url="https://github.com/jac18281828/bedrock" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="git@github.com:jac18281828/bedrock.git" \
    org.label-schema.vendor="John Cairns" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
