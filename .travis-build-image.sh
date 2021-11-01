if [ "${TRAVIS_BRANCH}" == "main" ] || [ "${TRAVIS_BRANCH}" == "master" ] || [ "${TRAVIS_BRANCH}" == "konveyor-dev" ]; then
  export TAG=latest
else
  export TAG=${TRAVIS_BRANCH}
fi

export IMAGE=quay.io/jmontleon/travis-multiarch-test:${TAG}
export ARCH=$(uname -m)

docker build -t ${IMAGE}-${ARCH} -f Dockerfile .
docker login quay.io -u "${QUAY_ROBOT}" -p ${QUAY_TOKEN}
docker push ${IMAGE}-${ARCH}
