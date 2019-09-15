FROM ubuntu:18.04

RUN apt-get update && apt-get install -yq --no-install-recommends \
  xvfb x11vnc \
  chocolate-doom

WORKDIR /app
COPY app .

ENV DISPLAY=:0
ENTRYPOINT ["/app/entrypoint.sh"]
