#!/bin/bash

DEFAULT_CHART_RELEASER_VERSION=v1.4.0

arch=$(uname -m)

version="$DEFAULT_CHART_RELEASER_VERSION"
cache_dir="$RUNNER_TOOL_CACHE/ct/$version/$arch"
if [[ ! -d "$cache_dir" ]]; then
  mkdir -p "$cache_dir"

  echo "Installing chart-releaser..."
  curl -sSLo cr.tar.gz "https://github.com/helm/chart-releaser/releases/download/$version/chart-releaser_${version#v}_linux_amd64.tar.gz"
  tar -xzf cr.tar.gz -C "$cache_dir"
  rm -f cr.tar.gz

  echo 'Adding cr directory to PATH...'
  export PATH="$cache_dir:$PATH"
fi

git fetch
git checkout "$CR_PAGES_BRANCH"

cr index

git add index.yaml
git commit -m "$CR_COMMIT_MESSAGE"
git push

git checkout -