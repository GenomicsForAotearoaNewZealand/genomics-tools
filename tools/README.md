This documentation describes the process and requirements for adding new tools to the **genomics-tools** repository. A **tool** is something that performs a specific job, such as "axe-demux" to run a demultiplexing step of a given pipeline.

## Create a new tool directory

A new directory must be created under the existing `tools` directory for each tool. This directory is referred to as ``${TOOL_NAME}`` in this documentation.

The name of the tool directory must be lowercase and use "-" (dash) for spaces. A version must not be suffixed to the tool name, because its will be captured as meta-data on the container image.

## Add required files to the tool directory

The tool directory must contain the following files:

**File** | **Description**
--- | ---
`alias.rc` | A script that creates the aliases required to run the tool as if it was installed locally
`Dockerfile` | A Docker file with all steps required to build the container image
`DOCS` | URL with documentation or instructions on how to use the tool
`install.sh` | An install script that takes care of all steps required to install the tool on top of the base image
`LICENSE` | The software license applicable to the tool
`MAINTAINER` | The email of the person that maintains the container image
`PAPER` | Where to find the scientific paper related to this tool
`README.md` | A description of the tool in mark down format
`test.sh` | A test script that runs automated tests to validate the tool works as expected
`VERSION` | The version of the tool

### Dockerfile

#### Meta-data standard

Container images must be labelled following the standard described below, so that images can be found and referenced appropriately by researchers.

**Standard** | **Label** | **Description** | **Source**
--- | --- | --- | ---
Docker | maintainer | Email of the maintainer of this container image | File: tools/${TOOL_NAME}/MAINTAINER
Label Schema RC1 | org.label-schema.schema-version | The version of the label schema being used (see http://label-schema.org) | Hard-coded: 1.0
Label Schema RC1 | org.label-schema.version | Release identifier for the image following the semantic versioning 2.0.0 convention (see https://semver.org) | File: tools/${TOOL_NAME}/VERSION
Label Schema RC1 | org.label-schema.vendor | The organization that produced this image | Hard-coded: Genomics for Aotearoa New Zealand
Label Schema RC1 | org.label-schema.name | A human friendly name for the image | Directory: tools/${TOOL_NAME}
Label Schema RC1 | org.label-schema.build-date | The date the image was built following the RFC 3339 format | Generated by the docker-build.sh script
Label Schema RC1 | org.label-schema.vcs-ref | Identifier for the version of the source code from which this image was built | GIT: ${COMMIT_ID}
Label Schema RC1 | org.label-schema.usage | Link to  URL that provides usage instructions | File: tools/${TOOL_NAME}/DOCS
Label Schema RC1 | org.label-schema.url | Where to find the scientific paper related to this tool | File: tools/${TOOL_NAME}/PAPER

#### Sample file

```Dockerfile
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
## Documentation
ARG DOCS
## URL to paper
ARG PAPER

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

#######
# Build
#######

# Update the apt database
RUN apt-get update

# Copy the install script
ADD install.sh /home/debian/

# Run the install script
RUN ["/bin/bash", "-cx", "/home/debian/install.sh"]

# Change the working directory to /mnt
WORKDIR /mnt

# Set the entrypoint
ENTRYPOINT ["/usr/bin/bowtie2"]
```

### install.sh

#### Requirements

The ``install.sh`` script must meet these requirements:
1.  If installed from external repositories or source code, binaries must be placed on `/opt` and added to `$PATH`.
1.  Temporary build files (such as source code packages or tarballs) must be stored on `/tmp`.

#### Sample file

```bash
#!/bin/bash

# This program is to set up a cloud image for the bowtie2 aligner version 2.3.0.
# It depends on a standard Debian 9 cloud instance.

# install bowtie2
apt-get -y install bowtie2
```

### test.sh

#### Requirements

The ``test.sh`` script must meet these requirements:
1.  The test script will print "GFANZ_TEST_RESULTS=OK" to the standard output if they succeed and exit with return code 0 (zero)
1.  The test script will print "GFANZ_TEST_RESULTS=ERROR" to the standard output if they fail and exit with return code 1 (one)

#### Sample file

```bash
#!/bin/bash

# Try bowtie2 --version and see if it is returns bowtie2-align-s.
# If it does, then output GFANZ_TEST_RESULTS=OK. If it does not, then output
# GFANZ_TEST_RESULTS=ERROR.
bowtie2 --version | grep bowtie2-align-s  >> /dev/null

if [ $? -eq 0 ]; then
  echo "GFANZ_TEST_RESULTS=OK"
  exit 0
else
  echo "GFANZ_TEST_RESULTS=ERROR"
  exit 1
fi
```

### LICENSE

#### Sample file

```
GNU General Public License v3.0
```

### MAINTAINER

#### Sample file

```
rob@elshiregroup.co.nz
```

### VERSION

#### Requirements

Release identifier for the image following the semantic versioning 2.0.0 convention (see https://semver.org).

#### Sample file

```
2.3.0
```

### DOCS

#### Sample file

```
http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml
```

### PAPER

#### Sample file

```
https://www.nature.com/articles/nmeth.1923
```

### README.md

#### Sample file

```
# Bowtie 2

## Description

Bowtie 2 is a tool for aligning sequence reads to a reference genome.
```

### alias.rc

#### Requirements

The command used to set up an alias that will run the containerised tool, as if it had been installed locally. If multiple aliases are required, they should be provided as a single line command (using `&&` to concatenate multiple aliases).

#### Sample file (single alias)

```
alias bowtie2='docker run -rm -v /mnt:/mnt gfanz/bowtie2'
```

#### Sample file (multiple aliases)
```
alias bowtie2='docker run -rm -v /mnt:/mnt gfanz/bowtie2' && alias bowtie2-align-s='docker run -rm -v /mnt:/mnt --entrypoint "/usr/bin/bowtie2-align-s" gfanz/bowtie2'
```