#!/bin/bash -x

# This script is used to create Docker images for the tools provided by this
# repository. It generates/collects all the meta-data needed to label the
# container and triggers the docker build process (passing the meta-data as
# arguments).

###################
# Collect meta-data
###################

# The tool name must be passed as an agument
if [ -z "${1}" ]; then
  echo "The tool name must be provided as an argument"
  exit 1
else
  TOOL_NAME="${1}"
  echo "TOOL_NAME ${TOOL_NAME}"
fi

cd "tools/${TOOL_NAME}"

MAINTAINER=$(cat MAINTAINER)

VERSION=$(cat VERSION)

DOCS=$(cat DOCS)

PAPER=$(cat PAPER)

COMMAND=$(cat alias.rc)

# The environment variable ${CI_COMMIT_SHORT_SHA} is defined by the Gitlab
# runner. If not set by Gitlab, then get it from git.
if ! [ -z "${CI_COMMIT_SHORT_SHA}" ]; then
  COMMIT_ID=${CI_COMMIT_SHORT_SHA}
else
  COMMIT_ID=$(git rev-parse --short HEAD)
fi
echo "COMMIT_ID ${COMMIT_ID}"

BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
echo "BUILD_DATE ${BUILD_DATE}"

# The environment variable ${CI_JOB_ID} is defined by the Gitlab runner and
# must be used when building images that will be added to the Docker registry,
# however, a date based alternative is generated to aid local testing of image
# generation.
if ! [ -z "${CI_JOB_ID}" ]; then
  BUILD_VERSION=$(echo "${CI_JOB_ID}")
else
  BUILD_VERSION="$(date +'%Y-%m-%dT%H:%M:%S')"
fi
echo "BUILD_VERSION ${BUILD_VERSION}"

# The URL of the version control system where the container source can be found
VCS_URL="https://gitlab.com/gfanz/genomics-tools"

###########################
# Build the container image
###########################

docker build --build-arg TOOL_NAME="${TOOL_NAME}" --build-arg MAINTAINER="${MAINTAINER}" --build-arg DOCS="${DOCS}" --build-arg PAPER="${PAPER}" --build-arg COMMAND="${COMMAND}" --build-arg VERSION="${VERSION}" --build-arg COMMIT_ID="${COMMIT_ID}" --build-arg BUILD_DATE="${BUILD_DATE}" --build-arg BUILD_VERSION="${BUILD_VERSION}" -t "${TOOL_NAME}" .

if [ $? -eq 0 ]; then
  echo "GFANZ_CONTAINER_BUILD=OK"
else
  echo "GFANZ_CONTAINER_BUILD=ERROR"
  exit 1
fi
