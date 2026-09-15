#!/bin/bash -e

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

# The release step runs `helm package -u`, which regenerates Chart.lock for any
# chart that has dependencies. semantic-release does not commit that file, so it
# is left modified and the checkout below aborts with
# "local changes would be overwritten by checkout: charts/<chart>/Chart.lock".
# Everything meant to be kept (CHANGELOG.md, Chart.yaml) was already committed and
# pushed by semantic-release, and the packaged *.tgz files are untracked, so
# discarding tracked modifications here is safe.
git checkout -- .

git checkout "$CR_PAGES_BRANCH"

cr index

git add index.yaml

# An unchanged index is a valid outcome - e.g. a re-run after a partial failure,
# where semantic-release correctly skips already-released charts and so produces
# no new package. Without this guard `git commit` fails and `bash -e` turns a
# no-op into a red build.
if git diff --cached --quiet; then
  echo "index.yaml unchanged - nothing to publish"
else
  git commit -m "$CR_COMMIT_MESSAGE"
  git push
fi

git checkout -
