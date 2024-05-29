#!/bin/bash
set -x

# Define base directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export BASE_DIR
export NODE_DIR="$BASE_DIR/node_modules"

if ! command -v nvm &> /dev/null; then
    echo "run install script"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "run install script"
    exit 1
fi

nvm use 20.14.0

# Move to base directory and check if node modules directory exists
cd $BASE_DIR

if [ ! -d "$NODE_DIR" ]; then
    echo "Directory $NODE_DIR does not exist"
    echo "run install script"
fi

echo "We're good to go, welcome to your npm environment"
