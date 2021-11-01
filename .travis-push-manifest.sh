#!/bin/bash
set -x

if [ "${TRAVIS_BRANCH}" == "main" ] || [ "${TRAVIS_BRANCH}" == "master" ] || [ "${TRAVIS_BRANCH}" == "konveyor-dev" ]; then
  export TAG=latest
else
  export TAG=${TRAVIS_BRANCH}
fi

export DOCKER_CLI_EXPERIMENTAL=enabled

docker manifest create \
  ${IMAGE}:${TAG} \
  ${IMAGE}:${TAG}-x86_64 \
  ${IMAGE}:${TAG}-ppc64le \
  ${IMAGE}:${TAG}-s390x \
  ${IMAGE}:${TAG}-aarch64
echo $?

docker manifest inspect ${IMAGE}:${TAG}
echo $?

docker login quay.io -u "${QUAY_ROBOT}" -p ${QUAY_TOKEN}

docker manifest push ${IMAGE}:${TAG}
