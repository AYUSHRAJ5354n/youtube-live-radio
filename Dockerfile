FROM alpine:3

RUN apk add --no-cache bash ffmpeg python3 py3-pip

RUN mkdir /usr/src/app -p
WORKDIR /usr/src/app/

ADD . /usr/src/app/
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s CMD curl --fail http://localhost:8080/health || exit 1
CMD ./stream.sh
