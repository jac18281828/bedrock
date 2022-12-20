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

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="bedrock" \
    org.label-schema.description="GMT6 and ETOPO1 Ice or Bedrock Container" \
    org.label-schema.url="https://github.com/jac18281828/bedrock" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="git@github.com:jac18281828/bedrock.git" \
    org.label-schema.vendor="John Cairns" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"
