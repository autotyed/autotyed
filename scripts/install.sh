#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  scripts/install_mac.sh
fi

# untested.
if [ "$(uname)" == "Linux" ]; then
  scripts/install_linux.sh
fi
