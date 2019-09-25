# Base image (note that a specific version of the base image must be used,
# never the "latest") or "stable"
FROM debian:9

##########
# Metadata
##########

# These arguments will be passed by the CI/CD job to label the image
## Maintainer is read from the MAINTAINER file in the tool directory
ARG MAINTAINER
## Version is read from the VERSION file in the tool directory
ARG VERSION
## Tool name is inherited from the directory name (under tools/*)
ARG TOOL_NAME
## Commit ID comes from Git
ARG COMMIT_ID
## Build date is generated using $(date -u +'%Y-%m-%dT%H:%M:%SZ')
ARG BUILD_DATE
## Build version
ARG BUILD_VERSION
## Documentation is read from the DOCS file in the tool directory
ARG DOCS
## URL to paper is read from the PAPER file in the tool directory
ARG PAPER
## Command is read from the alias.rc file in the tool directory
ARG COMMAND

# The author of this container image
LABEL maintainer="$MAINTAINER"
# Release identifier for the image following https://semver.org
LABEL org.label-schema.version="$VERSION"
# Additional lables following the convention of http://label-schema.org
LABEL org.label-schema.schema-version="1.0"
# The organization that produces this image.
LABEL org.label-schema.vendor="Genomics for Aotearoa New Zealand"
# A human friendly name for the image (the tool directory name)
LABEL org.label-schema.name="gfanz/$TOOL_NAME"
# The date the image was built following the RFC 3339 format
LABEL org.label-schema.build-date="$BUILD_DATE"
# Identifier for the version of the source code from which this image was built
LABEL org.label-schema.vcs-ref="$COMMIT_ID"
# Where to find documentation or instructions on how to use the tool
LABEL org.label-schema.usage="$DOCS"
# Where to find the scientific paper related to this tool
LABEL org.label-schema.url="$PAPER"
# Command used to set up aliases for the containerised tool
LABEL org.label-schema.docker.cmd="$COMMAND"

#######
# Build
#######

# Update the apt database
RUN apt-get update

# Copy the install script
ADD install.sh /home/debian/

# Copy the test script
ADD test.sh /home/debian/

# Run the install script
RUN ["/bin/bash", "-cx", "/home/debian/install.sh"]

# Change the working directory to /mnt
WORKDIR /mnt

# Set the entrypoint
ENTRYPOINT ["/opt/meraculous/bin/meraculous.pl"]
