#!/bin/bash

# Define base directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export BASE_DIR

# if ! command -v nvm &> /dev/null; then
#     echo "error, can't find nvm, run the install script"
#     exit 1
# fi

if ! command -v npm &> /dev/null; then
    echo "error, can't find npm, run the install script"
    exit 1
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm use 20.14.0

# Move to base directory and check if node modules directory exists
cd $BASE_DIR

export NODE_DIR="$BASE_DIR/node_modules"


if [ ! -d "$NODE_DIR" ]; then
    echo "Directory $NODE_DIR does not exist"
    echo "run install script"
fi

echo "We're good to go, welcome to your npm environment"
