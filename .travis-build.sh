export image=quay.io/jmontleon/travis-multiarch-test:latest
export ARCH=$(uname -m)

docker build -t ${image}-${ARCH} -f Dockerfile .
docker login quay.io -u "$QUAY_ROBOT" -p $QUAY_TOKEN
docker push ${image}-${ARCH}
