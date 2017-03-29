#!/bin/bash -x

if [[ $CELERITE_BUILDING_PAPER == false ]]; then
  return
fi

# Build the paper
cd paper
make

# Push to GitHub
if [ -n "$GITHUB_API_KEY" ]; then
  cd $TRAVIS_BUILD_DIR
  git checkout --orphan $TRAVIS_BRANCH-pdf
  git rm -rf .
  git add -f paper/paper1/ms.pdf
  git add -f paper/paper2/celerite2.pdf
  git -c user.name='travis' -c user.email='travis' commit -m "building the papers"
  git push -q -f https://$GITHUB_USER:$GITHUB_API_KEY@github.com/$TRAVIS_REPO_SLUG $TRAVIS_BRANCH-pdf
fi
