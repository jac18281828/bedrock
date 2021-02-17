FROM debian:bullseye-slim as builder

RUN apt update && \
    apt -y install gmt curl gzip

WORKDIR /bedrock


RUN curl -q --silent --output /bedrock/ETOPO1_Bed_g_gmt4.grd.gz https://ngdc.noaa.gov/mgg/global/relief/ETOPO1/data/bedrock/grid_registered/netcdf/ETOPO1_Bed_g_gmt4.grd.gz
RUN gunzip /bedrock/ETOPO1_Bed_g_gmt4.grd.gz

# optionally cut the region down to size
#ARG EAST=42
#ARG WEST=-5
#ARG NORTH=55
#ARG SOUTH=29
# 
# RUN gmt grdcut /bedrock/ETOPO1_Bed_g_gmt4.grd -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO1_europe_asiaminor.grd

FROM debian:bullseye-slim

RUN apt update && \
    apt -y install gmt gmt-gshhg-high ghostscript

COPY --from=builder /bedrock/ETOPO1_Bed_g_gmt4.grd /bedrock/ETOPO1_Bed_g_gmt4.grd

CMD echo Bedrock!
