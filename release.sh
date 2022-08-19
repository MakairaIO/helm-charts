#!/bin/bash -e

runSemanticRelease() {
  cp .releaserc.json "$1"
  echo "{\"name\":\"${1#charts/}\"}" >"$1/package.json"
  DIR_PATH=$(pwd)
  cd "$1" || exit
  "$DIR_PATH/node_modules/.bin/semantic-release"

  cd ../..
}

if [[ "$1" == "common" ]]; then
  echo "[Script] Running semantic-release for charts/common"
  runSemanticRelease "charts/common"
  exit 0
fi

for chart in charts/*; do
  echo "[Script] Running semantic-release for $chart"
  runSemanticRelease "$chart"
done
