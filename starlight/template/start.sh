#!/bin/bash
set -e

# Define base directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export BASE_DIR

cd $BASE_DIR

npm run dev
