#!/bin/bash

echo_hits="======>"
echo_subHits="  ====>"
USAGE="
Usage:
  $0 [COMMAND] [-v <virtualenv>] -f <file>
  $0 -h|--help
Commands:
  start        start specify docker-compose repo
  stop         stop specify docker-compose repo
  restart      restart specify docker-compose repo
Options:
  -v, --virtualenv VENV  Specify an alternate python virtualenv (default: python)
  -f, --file FILE        Specify an alternate docker-compose.yml file
"

# usage
if [[ "$@" = *--help ]] || [[ "$@" = *-h ]]; then
  echo "$USAGE"
  exit 1
fi

# paser args
while [[ $# -gt 0 ]]
do
case $1 in
    start|stop|restart)
    COMMAND="$1"
    shift
    ;;
    -v|--virtualenv)
    VIRTUALENV="$2"
    shift
    shift
    ;;
    -f|--file)
    FILE="$2"
    shift
    shift
    ;;
    *)
    echo "unknown opt: " "$1"
    echo "$USAGE"
    exit 3
    ;;
esac
done

# echo_testHits="==test==>"
# echo "$echo_testHits" COMMAND = "$COMMAND"
# echo "$echo_testHits" VIRTUALENV = "$VIRTUALENV"
# echo "$echo_testHits" FILE = "$FILE"

# activate virtualenv
if [[ ! -z "$VIRTUALENV" ]]; then
    echo "$echo_hits workon python virtualenv $VIRTUALENV"
    # set python version
    # if type -p python3; then
    #     VIRTUALENVWRAPPER_PYTHON=$(which python3)
    # else
    #     VIRTUALENVWRAPPER_PYTHON=$(which python2)
    # fi
    VIRTUALENVWRAPPER_PYTHON=$(type -p python3 || type -p python2)
    echo "$echo_subHits VIRTUALENVWRAPPER_PYTHON is $VIRTUALENVWRAPPER_PYTHON"
    export WORKON_HOME=$HOME/.virtualenvs
    source $(which virtualenvwrapper.sh)
    workon "$VIRTUALENV"
fi

# swich command
if [[ "$COMMAND" = "restart" ]] || [[ "$COMMAND" = "stop" ]]; then
    echo "$echo_hits stop docker-compose and rm images while run docker-compose"
    if [[ -z "$FILE" ]] && [[ "$(docker-compose ps -q)" ]]; then
        echo "$echo_subHits stop in current dir"
        docker-compose down --rmi local
    elif [[ "$(docker-compose -f "$FILE" ps -q)" ]]; then
        echo "$echo_subHits stop using config file $FILE"
        docker-compose -f "$FILE" down --rmi local
    else
        echo "$echo_subHits docker-compose $FILE not running"
    fi
fi
if [[ "$COMMAND" = "restart" ]] || [[ "$COMMAND" = "start" ]]; then
    echo "$echo_hits build docker-compose images without cache and run it"
    if [[ -z "$FILE" ]]; then
        echo "$echo_subHits start with --no-cache in current dir"
        docker-compose build --no-cache
        docker-compose up -d
    else
        echo "$echo_subHits start with --no-cache and using config file $FILE"
        docker-compose -f "$FILE" build --no-cache
        docker-compose -f "$FILE" up -d
    fi
fi

# move to `stop.sh` do remove dangling images
# stop.sh script now to rm docker-compose created images
# if [[ ! -z $(docker images -f dangling=true -aq) ]]; then
#   echo "$echo_hits" "remove old docker images"
#   docker rmi $(docker images -f dangling=true -aq)
# fi

# deactivate virtualenv
if [[ ! -z "$VIRTUALENV" ]]; then
    echo "$echo_hits deactivate python virtualenv $VIRTUALENV"
    deactivate
fi
