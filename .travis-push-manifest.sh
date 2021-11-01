if [ "${TRAVIS_BRANCH}" == "main" ] || [ "${TRAVIS_BRANCH}" == "master" ] || [ "${TRAVIS_BRANCH}" == "konveyor-dev" ]; then
  export TAG=latest
else
  export TAG=${TRAVIS_BRANCH}
fi

export IMAGE=quay.io/jmontleon/travis-multiarch-test:${TAG}
export DOCKER_CLI_EXPERIMENTAL=enabled

docker manifest create \
  ${IMAGE} \
  ${IMAGE}-x86_64 \
  ${IMAGE}-ppc64le \
  ${IMAGE}-s390x \
  ${IMAGE}-arm64

docker manifest inspect ${IMAGE}

docker login quay.io -u "${QUAY_ROBOT}" -p ${QUAY_TOKEN}

docker manifest push ${IMAGE}
