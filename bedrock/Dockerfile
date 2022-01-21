FROM debian:stable-slim as builder
ARG ETOPO_GRIDFILE
ARG ETOPO_URL
RUN apt update && \
        apt install -y -q --no-install-recommends \
        gzip ca-certificates
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /bedrock

# fetch and unzip ETOPO Grid file
ADD ${ETOPO_URL} /bedrock/${ETOPO_GRIDFILE}.gz
RUN gunzip /bedrock/${ETOPO_GRIDFILE}.gz

FROM debian:stable-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
        apt update && \
        apt install -y -q --no-install-recommends \
        gmt gmt-gshhg-high ghostscript

RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

COPY --from=builder /bedrock/${ETOPO_GRIDFILE} /bedrock/${ETOPO_GRIDFILE}

CMD echo ${ETOPO_GRIDFILE}!