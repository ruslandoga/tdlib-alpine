FROM alpine:3.17.2 AS builder

RUN apk add --update --no-cache alpine-sdk linux-headers git zlib-dev openssl-dev gperf php cmake
RUN git clone https://github.com/tdlib/td.git /td
RUN mkdir -p /td/build
WORKDIR /td/build/
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
RUN cmake --build . --target install
RUN ls -l /usr/local

FROM alpine:3.17.2

COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include /usr/local/include
