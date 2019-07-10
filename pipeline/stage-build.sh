#!/bin/bash -x
# The build stage is responsible for creating a contianer image and saving it
# to the local file-system of the CI runner host, so it can be used by
# subsequent stages of the CI/CD pipeline.

# If no arguments were passed, show help and exit.
if [[ $# -eq 0 ]]; then
  echo "Use $0 [TOOL_DIRECTORY]"
  exit 1
fi
# Tool directory is expected as the first argument.
TOOL="${1}"

# Use the docker-build.sh script to create a container image for the tool.
echo "Building container image for ${TOOL}."
pipeline/docker-build.sh "${TOOL}"
if [ $? -eq 0 ]; then
  echo "Container image build for ${TOOL} succeeded."
else
  echo "Container image build for ${TOOL} failed. Exiting."
  exit 1
fi

# Save the container image produced to the local filesystem, so that the test
# stage of the pipeline can pick it up and use it.
echo "Saving container image for ${TOOL}."
docker image save ${TOOL} -o image/${TOOL}.tar
if [ $? -ne 0 ]; then
  echo "Saving container image build for ${TOOL} failed. Exiting."
  exit 1
fi

exit 0
