FROM debian:bullseye AS builder

RUN apt-get update && apt-get install -yq make gcc busybox-static

WORKDIR /code
ENV STRESS_VER=0.09.41
ADD https://github.com/ColinIanKing/stress-ng/archive/V${STRESS_VER}.tar.gz .
RUN tar -xf V${STRESS_VER}.tar.gz && mv stress-ng-${STRESS_VER} stress-ng

# make static version
WORKDIR /code/stress-ng
RUN STATIC=1 make

# Final image
FROM scratch

# copy stress-ng
COPY --from=builder /code/stress-ng/stress-ng /

# copy static sleep
COPY --from=builder /bin/busybox /bin/sleep

ENTRYPOINT ["/stress-ng"]