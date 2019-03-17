#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  scripts/macos/install_all.sh
fi

# untested.
if [ "$(uname)" == "Linux" ]; then
  scripts/linux/install_all.sh
fi
