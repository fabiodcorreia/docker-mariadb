#!/bin/bash

docker build . -t mariadb
docker run --rm --entrypoint '/bin/sh' -v ${PWD}:/tmp mariadb -c -c '\
  apk info -v | sort > /tmp/package_versions.txt && \
  chmod 777 /tmp/package_versions.txt'
