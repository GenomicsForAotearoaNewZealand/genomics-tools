#!/bin/bash

# This script updates the labels in the Dockerfile to conform to the opencontainers.org image spec.
# The label-schema.org spec has been deprecated.

# Usage: run this script in the directory with the Dockerfile you want to update.

# The form of the script is the section to be changed, the old version, then the new version in comments.
# Then the sed command to make the change.

# The author of this container image
#LABEL maintainer="$MAINTAINER"
#LABEL org.opencontainers.image.authors="$MAINTAINER"    

sed -i -e 's,maintainer,org.opencontainers.image.authors,g' Dockerfile

# Release identifier for the image following https:,,semver.org
#LABEL org.label-schema.version="$VERSION"
#LABEL org.opencontainers.image.version=

sed -i -e 's,org.label-schema.version,org.opencontainers.image.version,g' Dockerfile

# Additional lables following the convention of http://label-schema.org
# This needs to be deleted because there is no equivalent
#LABEL org.label-schema.schema-version="1.0"

sed -i -e 's,# Additional lables following the convention of http://label-schema.org,,g' Dockerfile
sed -i -e 's,LABEL org.label-schema.schema-version="1.0",,g' Dockerfile

# The organization that produces this image.
#LABEL org.label-schema.vendor="Genomics for Aotearoa New Zealand"
#LABEL org.opencontainers.image.vendor=

sed -i -e 's,org.label-schema.vendor,org.opencontainers.image.vendor,g' Dockerfile

# A human friendly name for the image (the tool directory name)
#LABEL org.label-schema.name="gfanz/$TOOL_NAME"
#LABEL org.opencontainers.image.title=

sed -i -e 's,org.label-schema.name,org.opencontainers.image.title,g' Dockerfile

# The date the image was built following the RFC 3339 format
#LABEL org.label-schema.build-date="$BUILD_DATE"
#LABEL org.opencontainers.image.created=

sed -i -e 's,org.label-schema.build-date,org.opencontainers.image.created,g' Dockerfile

# Identifier for the version of the source code from which this image was built
#LABEL org.label-schema.vcs-ref="$COMMIT_ID"
#LABEL org.opencontainers.image.revision=

sed -i -e 's,org.label-schema.vcs,org.opencontainers.image.revision,g' Dockerfile

# Where to find documentation or instructions on how to use the tool
#LABEL org.label-schema.usage="$DOCS"
#LABEL org.opencontainers.image.documentation=

sed -i -e 's,org.label-schema.usage,org.opencontainers.image.documentation,g' Dockerfile

# Where to find the scientific paper related to this tool
#LABEL org.label-schema.url="$PAPER"
#LABEL org.opencontainers.image.url

sed -i -e 's,org.label-schema.url,org.opencontainers.image.url,g' Dockerfile

# Command used to set up aliases for the containerised tool
# Leaving this as is because I am not sure if there is a need to change it.
#LABEL org.label-schema.docker.cmd="$COMMAND"
