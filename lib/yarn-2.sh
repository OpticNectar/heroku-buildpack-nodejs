#!/usr/bin/env bash

YQ="$BP_DIR/lib/vendor/yq-$(get_os)"

detect_yarn_2() {
  local uses_yarn="$1"
  local build_dir="$2"
  local yml_metadata
  local version

  yml_metadata=$($YQ r "$build_dir/yarn.lock" __metadata 2>&1)

  # grep for version in case the output is a parsing error
  version=$(echo "$yml_metadata" | grep version)

  if [[ "$uses_yarn" == "true" && "$version" != "" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

get_yarn_path() {
  local build_dir="$1"
  $YQ r "$build_dir/.yarnrc.yml" yarnPath 2>&1
}
