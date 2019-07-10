#!/bin/bash -x
# The test stage is responsible for tesing the container image produced and
# validating it works as expected.

# If no arguments were passed, show help and exit.
if [[ $# -eq 0 ]]; then
  echo "Use $0 [TOOL_DIRECTORY]"
  exit 1
fi
# Tool directory is expected as the first argument.
TOOL="${1}"

# Load the container image produced by the build stage of the pipeline.
echo "Loading container image for ${TOOL}."
docker image load -i image/${TOOL}.tar
if [ $? -ne 0 ]; then
  echo "Loading container image for ${TOOL} failed. Exiting."
  exit 1
fi

# Run tests to validate the container works as expected.
docker run -v ${CI_PROJECT_DIR}/tools/${TOOL}:/mnt --entrypoint "/home/debian/test.sh" ${TOOL}
if [ $? -eq 0 ]; then
  echo "Tests for ${TOOL} succeeded."
else
  echo "Tests for ${TOOL} failed. Exiting."
  exit 1
fi

exit 0
