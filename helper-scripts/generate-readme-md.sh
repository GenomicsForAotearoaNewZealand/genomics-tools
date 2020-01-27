#!/bin/bash

# This helper script is for creating README.md files
# from the various metadata files associated with 
# the tools.

# The README.md file must be added to the tool page
# on hub.docker.com manually We are looking for a way 
# to automate this with the CI/CD system on gitlab.

# Run the script in the directory with the tool and 
# associated metadata files.

echo "## Tool Name" > README.md

# Put the name of the tool folder as the name of the tool.
printf '%q\n' "${PWD##*/}" >> README.md

echo "## Version" >> README.md

cat VERSION >> README.md

echo "## Citation" >> README.md

cat PAPER >> README.md

echo "## How to use GFANZ Docker Containers" >> README.md

echo "https://gitlab.com/gfanz/genomics-tools/-/wikis/home" >> README.md

echo "## Documentation" >> README.md

cat DOCS >> README.md

echo "## Source Code" >> README.md

cat SOURCE >> README.md

echo "## License" >> README.md

cat LICENSE >> README.md


