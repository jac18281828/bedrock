# bedrock

GMT 6 and ETOPO1 Docker image [Bedrock](https://hub.docker.com/r/jac18281828/bedrock)

[Releases](https://github.com/jac18281828/bedrock/releases)

![ETOPO1 Ice](bedrock/etopo1_small_copper.png)

Ice surface also available from tag: etopo1-gmt6-ice-${VERSION}

Also available from [GitHub GHCR](https://github.com/jac18281828/bedrock/pkgs/container/bedrock)

### Architecture
* linux/amd64 
* linux/arm64

Example Dockerfile
 - use as a builder 
 - cut down grid file to a specific region

```
FROM jac18281828/bedrock:ice_surface as builder

WORKDIR /bedrock

ARG EAST=42
ARG WEST=-5
ARG NORTH=55
ARG SOUTH=29

RUN gmt grdcut /bedrock/ETOPO1_Ice_g_gmt4.grd -R${WEST}/${EAST}/${SOUTH}/${NORTH} -G/bedrock/ETOPO1_asiaminor.grd

FROM debian:stable-slim

RUN apt update && \
    apt -y install gmt gmt-gshhg-high ghostscript

COPY --from=builder /bedrock/ETOPO1_asiaminor.grd /bedrock/ETOPO1_asiaminor.grd

CMD echo Bedrock!
```

Example Map: Copper World Relief (seen above):

```
#!/usr/bin/env bash

ETOPO1=/bedrock/ETOPO1_Ice_g_gmt4.grd

gmt begin /output/world
gmt makecpt -Ccopper -T-18000/28500
gmt grdimage ${ETOPO1} -n+c
gmt end
```

Complete [working example](https://gist.github.com/jac18281828/78c28ee0e00b1936622b17cc783b2701)

