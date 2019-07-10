# CI/CD pipeline

When a **merge request is submitted** by a contributor, a job is triggered to:
1.  Build a new container image for each tool modified.
1.  Test that the images produced work as expected, by running automated tests
    for each tool.

**If the test job succeeds**, then one of the reviewers of the genomics-tools
project will review the code change and merge it.

When a **merge request is accepted** by a reviewer, a job is triggered to:
1.  Build a new container image for each tool modified.
1.  Test that the images produced work as expected, by running automated tests
    for each tool.
1.  Publish images that work successfully to the remote Docker Hub registry with
    the *latest* tag.

## Build stage

The **build stage** will:
1.  Identify if the merge request includes any changes to the `tools/*`
    directory. If yes, for each tool (directory) modified:
    1.  Run the `docker-build.sh` to build a new container image.
    1.  Save the image produced to the local file-system.

## Test stage

The **test stage** will:
1.  Load the container image from the local file-system.
1.  Run the container and test it using the automated tests defined in
    `tools/${TOOL_NAME}/test.sh`, returning `SUCCESS` if all tests pass, or
    `FAIL` if any of them fail.

If the test job **succeeds**, then one of the reviewers of the genomics-tools
project will review the code change and merge it.

## Deploy stage

The **deploy stage** will:
1.  Publish the new version of the tool image to Docker Hub.