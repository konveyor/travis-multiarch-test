export image=quay.io/jmontleon/travis-multiarch-test:latest
export DOCKER_CLI_EXPERIMENTAL=enabled

docker manifest create \
  ${image} \
  ${image}-x86_64 
  ${image}-ppc64le
  ${image}-s390x
  ${image}-arm64

docker manifest inspect ${image}

docker login quay.io -u "$QUAY_ROBOT" -p $QUAY_TOKEN

docker manifest push ${image}
