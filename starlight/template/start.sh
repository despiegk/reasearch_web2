#!/bin/bash
set -e

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export BASE_DIR
cd $BASE_DIR
source myenv.sh

#following opens the webpage on osx and waits 3 sec before going there
if [ "$(uname)" == "Darwin" ]; then
    session_name="linkopen"    
    if screen -list | grep -q "\.${session_name}"; then
        screen -S $session_name -X quit
    fi
    screen -dmS $session_name bash -c "sleep 3 && open http://localhost:4321/"
fi

npm run dev
