#!/bin/bash

if [ "${TRAVIS_BRANCH}" == "${DEFAULT_BRANCH}" ]; then
  export TAG=latest
  docker tag ${IMAGE}:${TRAVIS_BRANCH}-${TRAVIS_CPU_ARCH} ${IMAGE}:latest
else
  export TAG=${TRAVIS_BRANCH}
fi

if [[ -n "${QUAY_ROBOT}" ]]; then
  docker login quay.io -u "${QUAY_ROBOT}" -p ${QUAY_TOKEN}
  docker push ${IMAGE}:${TAG}
fi
