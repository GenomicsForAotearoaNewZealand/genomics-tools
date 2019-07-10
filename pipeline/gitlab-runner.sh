#!/bin/bash
# This script demonstrates how to set up a Gitlab CI runner on a Debian 9
# compute instance

# Change project registration token with value provided by Gitlab
PROJECT_REGISTRATION_TOKEN="1234567890"

# Update package sources and upgrade all packages
apt-get update
apt-get upgrade -y

# Install and configure unattended upgrades, so packages are always ket up to date
apt-get install -y unattended-upgrades apt-listchanges

# Create a user for the GitLab Runner
useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
# Download the binary and make it executable
wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
chmod +x /usr/local/bin/gitlab-runner
# Install Docker
apt-get install -y curl
curl -sSL https://get.docker.com/ | sh
usermod -aG docker gitlab-runner
# Install and start the GitLab Runner
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
gitlab-runner start
# Register the runner with Gitlab.com
gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.com/" \
  --registration-token "$PROJECT_REGISTRATION_TOKEN" \
  --executor "docker" \
  --docker-image docker:latest \
  --description "docker-runner" \
  --tag-list "docker,catalyst-cloud" \
  --run-untagged \
  --locked="false"
# Register the builder with Gitlab.com
gitlab-runner register -n \
  --url "https://gitlab.com/" \
  --registration-token "$PROJECT_REGISTRATION_TOKEN" \
  --executor "docker" \
  --description "docker-builder" \
  --docker-image "docker:latest" \
  --docker-privileged

