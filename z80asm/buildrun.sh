#!/usr/bin/env bash
# call build && run scripts
THIS_DIR=$(dirname "${BASH_SOURCE[0]}")
"$THIS_DIR/build.sh" "$1" "$2" && "$THIS_DIR/run.sh" "$1" "$2"
