#!/bin/bash -x
# The deploy stage is responsible for tagging and publishing working container
# images to the container registry.

# If no arguments were passed, show help and exit.
if [[ $# -eq 0 ]]; then
  echo "Use $0 [TOOL_DIRECTORY]"
  exit 1
fi
# Tool directory is expected as the first argument.
TOOL="${1}"

# Load the container image created by the build stage and validated by the test
# stage from the file-system.
echo "Loading container image for ${TOOL}."
docker image load -i image/${TOOL}.tar
if [ $? -ne 0 ]; then
  echo "Loading container image for ${TOOL} failed. Exiting."
  exit 1
fi

# Log in to the container registry, tag and push the image. The variables
# ${DOCKER_IO_USER} and ${DOCKER_IO_PASSWORD} must to be defined in the project.
# The password should be 'masked' so it does not get shown in the CI logs.
# To work around quirks in Gitlab's docker login, a 'file' variable CONFIG_JSON
# needs to be defined and its contents must be a valid docker 'config.json' for
# this user.
echo "Log in to container repository."
docker login -u ${DOCKER_IO_USER} -p ${DOCKER_IO_PASSWORD} ${EXTERNAL_REGISTRY}/${CI_PROJECT_NAMESPACE}/${TOOL}
if [ $? -ne 0 ]; then
  echo "Docker login failed. Exiting."
  exit 1
fi

# Tag the image with teh "${VERSION}", "${VERSION}-${CI_COMMIT_SHORT_SHA}", and
# "latest" tags.
echo "Tagging ${EXTERNAL_REGISTRY}/${CI_PROJECT_NAMESPACE}."
VERSION=$(cat tools/${TOOL}/VERSION)
TAGS="${CI_PROJECT_NAMESPACE}/${TOOL}:latest
${CI_PROJECT_NAMESPACE}/${TOOL}:${VERSION}
${CI_PROJECT_NAMESPACE}/${TOOL}:${VERSION}-${CI_COMMIT_SHORT_SHA}"
for TAG in ${TAGS}; do
  docker tag ${TOOL}:latest ${TAG}
  if [ $? -ne 0 ]; then
    echo "Tag of ${TOOL} with ${TAG} failed. Exiting."
    exit 1
  fi
done

# Push the tagged image to the container registry under the defined namespace.
echo "Pushing container image to registry."
docker push ${CI_PROJECT_NAMESPACE}/${TOOL}
if [ $? -ne 0 ]; then
  echo "Pushing ${TOOL} to ${CI_PROJECT_NAMESPACE}/${TOOL} failed. Exiting."
  exit 1
fi

exit 0
