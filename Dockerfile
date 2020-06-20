FROM fabiodcorreia/base-alpine:1.0.0

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="fabiodcorreia"

# environment variables
ENV MARIADB_VERSION="10.4.13"
ENV CONFIG_DIR="/config"
ENV DATADIR=$CONFIG_DIR/databases

RUN \
  echo "**** install runtime packages ****" && \
    apk add --no-cache mariadb mariadb-client && \
  echo "**** cleanup ****" && \
  rm -rf \
	  /tmp/* \
	  /var/lib/mysql \
	  /var/tmp/* && \
  mkdir -p \
	  /var/lib/mysql

# add local files
COPY root/ /

# ports and volumes
EXPOSE 3306
VOLUME /config
