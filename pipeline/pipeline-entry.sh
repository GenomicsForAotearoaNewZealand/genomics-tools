#!/bin/bash -x

# In order to find out what tools have been modified by a change, the type of
# event triggering the CI/CD pipeline must be identified, so that the
# appropriate git command can be used to compare the proposed change versus the
# master branch and find out what has been modified.
DELTA_SRC=''
echo ${CI_COMMIT_MESSAGE} | grep -q "See merge request ${CI_PROJECT_NAMESPACE}/${CI_PROJECT_NAME}"
if [ $? -eq 0 -a ${CI_PIPELINE_SOURCE} == 'push' ]; then
  echo "CI/CD triggered by a merge event."
  DELTA_SRC='merge'
elif [ ${CI_COMMIT_REF_NAME} != "master" -a ${CI_PIPELINE_SOURCE} == 'push' ]; then
  echo "CI/CD triggered by a branch push event."
  DELTA_SRC='branch_push'
else
  echo "Not a merge or branch push, so nothing for CI/CD to do. Exiting."
  exit 0
fi

# If the event is a merge then the SVC changes can be found by comparing the
# difference between the two commit IDs that are supplied by the CI. Otherwise,
# if it is a branch push, then the changes can be found by comparing with
# origin/master. However, due to some non deterministic behaviour from Gitlab
# we fetch the master branch to be sure it exists.
if [ ${DELTA_SRC} == 'merge' ]; then
  DELTA_BEFORE_TAG=${CI_COMMIT_BEFORE_SHA}
  DELTA_TAG=${CI_COMMIT_SHA}
else
  DELTA_BEFORE_TAG='origin/master'
  DELTA_TAG=${CI_COMMIT_SHA}
  git fetch origin master
fi

# Find out what tools have been modified in this change.
TOOLS_MODIFIED=$(git diff ${DELTA_BEFORE_TAG} ${DELTA_TAG} --name-only | grep "^tools/" | cut -d'/' -f2 | sort | uniq)

# If nothing changed, exit the job immediately. Otherwise, run the current
# stage of the pipeline for the tool(s) modified. The environment variable
# ${CI_JOB_STAGE} is defined by Gitlab CI.
#
# There are three stages defined at the moment:
# - build: runs the docker-build.sh script against the modified ${TOOL},
#   creating a container image for it and saving the image to the local
#   filesystem.
#
# - test: reads the image from the local filesystem, creates a container from
#   it, and runs the tests defined to validate it works.
#
# - deploy: reads the image from the local filesystem, pushes it to Docker Hub.
#
if [[ ${TOOLS_MODIFIED} == "" ]]; then
  echo "No tools modified. Nothing to do."
  exit 0
else
  for TOOL in ${TOOLS_MODIFIED}; do
    if TOOL == "README.md"; then
        echo "README.md modified moving on"
    else    
    bash -x "pipeline/stage-${CI_JOB_STAGE}.sh" "${TOOL}"
        if [ $? -eq 0 ]; then
        echo "Stage ${CI_JOB_STAGE} for ${TOOL} succeeded."
        else
          echo "Stage ${CI_JOB_STAGE} for ${TOOL} failed. Exiting."
          exit 1
        fi
    fi
  done
fi

exit 0
