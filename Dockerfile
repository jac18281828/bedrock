FROM debian:stable-slim as builder

RUN apt update && \
        apt install -y -q --no-install-recommends \
        gzip ca-certificates
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /bedrock

# fetch and unzip ETOPO1 Bedrock Grid file
ADD https://ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/bedrock/grid_registered/netcdf/ETOPO1_Bed_g_gmt4.grd.gz /bedrock/ETOPO1_Bed_g_gmt4.grd.gz
RUN gunzip /bedrock/ETOPO1_Bed_g_gmt4.grd.gz

FROM debian:stable-slim

RUN export DEBIAN_FRONTEND=noninteractive && \
        apt update && \
        apt install -y -q --no-install-recommends \
        gmt gmt-gshhg-high ghostscript

RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

COPY --from=builder /bedrock/ETOPO1_Bed_g_gmt4.grd /bedrock/ETOPO1_Bed_g_gmt4.grd

CMD echo Bedrock!
