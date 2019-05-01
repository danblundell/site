#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# remove public if it exists
rm -R public

# clone the built site as the public directory
git clone git@github.com:danblundell/danblundell.github.io.git public

# Build the project (its running in a docker container, so run the build there)
docker exec danblundell_blog hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..