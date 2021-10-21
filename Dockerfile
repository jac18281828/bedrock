FROM debian:stable-slim as builder

RUN apt update && \
    apt -y install curl gzip

WORKDIR /bedrock

# fetch and unzip ETOPO1 Bedrock Grid file
RUN curl -q --silent --output /bedrock/ETOPO1_Bed_g_gmt4.grd.gz https://ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/bedrock/grid_registered/netcdf/ETOPO1_Bed_g_gmt4.grd.gz
RUN gunzip /bedrock/ETOPO1_Bed_g_gmt4.grd.gz

FROM debian:bullseye-slim

RUN apt update && \
    apt -y install gmt gmt-gshhg-high ghostscript

COPY --from=builder /bedrock/ETOPO1_Bed_g_gmt4.grd /bedrock/ETOPO1_Bed_g_gmt4.grd

CMD echo Bedrock!
