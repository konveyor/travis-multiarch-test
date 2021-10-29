FROM quay.io/konveyor/builder:latest
CMD echo "Hello World from a container running on $(uname -m)"
