# bedrock

GMT 6.1, Debian Bullseye slim and ETOPO1 Bedrock

Example Dockerfile - use as a builder but cut down grid file to a specific region

Ice surface is also available from tag: etopo1-gmt6-ice-${VERSION}


```
FROM jac18281828/bedrock:latest as builder

WORKDIR /bedrock

ARG EAST=42
ARG WEST=-5
ARG NORTH=55
ARG SOUTH=29

RUN gmt grdcut /bedrock/ETOPO1_Bed_g_gmt4.grd -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO1_asiaminor.grd

FROM debian:bullseye-slim

RUN apt update && \
    apt -y install gmt gmt-gshhg-high ghostscript

COPY --from=builder /bedrock/ETOPO1_asiaminor.grd /bedrock/ETOPO1_asiaminor.grd

CMD echo Bedrock!
```
