# GFANZ Genomics Tools

This repository contains a collection of of curated genomics tools and
workflows. For more information about the project and instructions on how to use the tools, see the [project wiki](https://gitlab.com/gfanz/genomics-tools/-/wikis/home)

[![pipeline status](https://gitlab.com/gfanz/genomics-tools/badges/master/pipeline.svg)](https://gitlab.com/gfanz/genomics-tools/commits/master)

## Contributing to this repository

The source code is hosted on https://gitlab.com/gfanz/genomics-tools and a copy 
is kept in github.com for convenience. Please submit merge requests via GitLab.

If you are not familiar with git, please check the dedicated wiki page: https://gitlab.com/gfanz/genomics-tools/wikis/Git-basic
## Proposing a new tool

Thank you for contributing. Please read `tools/README.md` for more information on the conventions and
structure required to add a tool to the repository.

### As a researcher, I want to propose a change

1.  Clone the repository: `git clone git@gitlab.com:gfanz/genomics-tools.git`
1.  Change directory to the cloned repository: `cd genomics-tools`
1.  Create a new branch: `git checkout -b [your-branch-name]`
1.  Create a new directory with your tool name.
1.  Copy the contents of the template tool directory into the directory you just created.
1.  Use your favourite code editor to propose your changes
1.  Commit when done: `git add . && git commit`
1.  Push changes back to Gitlab: `git push --set-upstream origin
    [your-branch-name]`
1.  Confirm at https://gitlab.com/gfanz/genomics-tools/pipelines that the
    continuous integration tests passed for the changes you did
1.  Go to https://gitlab.com/gfanz/genomics-tools/merge_requests and click on
    `Create merge request` (blue button on the top right)
1.  On the next page click on `Submit merge request` (green button at the bottom
    of the page)
1.  Once the change has been accepted and merged by reviewer, clean up the local repository by:
    1. Change to the master branch: `git checkout master` 
    1. Fetch the remote, bringing the branches and their commits from the remote repository. The -p, --prune option deletes any remote-tracking references that no longer exist in the remote: `git fetch -p origin`
    1. Merge the changes from origin/master into your local master branch. This brings your master branch in sync with the remote repository, without losing your local changes. If your local branch didn't have any unique commits, Git will instead perform a "fast-forward". `git merge origin/master`
    1. Remove your working branch: `git branch -d [your-branch-name]`

### As a reviewer, I want to accept and merge a change

1.  Go to https://gitlab.com/gfanz/genomics-tools/merge_requests, find out the
    merge request to review and click on it
1.  Check the results of the tests:
    1.  If the tests have failed, click on `Close merge request` (orange button
        on top right) and wait until the researcher can pass all tests
    1.  If the tests have succeeded:
        1.  Review the code change by clicking on the `Changes` tab at the
            bottom of the page
        1.  If you are happy with the changes proposed, check the `Delete source
            branch` box and click on the `Merge` button

