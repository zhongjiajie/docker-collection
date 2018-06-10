#!/usr/bin/env bash

# cd bin folder to do subcommand
cd ${ROCKETMQ_HOME}/bin && export JAVA_OPT=" -Duser.home=/opt"

case "$1" in
  namesrv)
    # rocketmq-4.1.0-incubating `runnamesrv.sh` original memory setting is `JAVA_OPT="${JAVA_OPT} -server -Xms4g -Xmx4g -Xmn2g -XX:PermSize=128m -XX:MaxPermSize=320m`"
    : "${JVM_MEMORY:="-Xms1g -Xmx1g -Xmn512m -XX:PermSize=64m -XX:MaxPermSize=256m"}"
    sed -i "s/-server -Xms4g -Xmx4g -Xmn2g -XX:PermSize=128m -XX:MaxPermSize=320m/${JVM_MEMORY}/g" runserver.sh
    exec sh mqnamesrv
    ;;
  broker)
    # rocketmq-4.1.0-incubating `runbroker.sh` original memory setting is `JAVA_OPT="${JAVA_OPT} -server -Xms8g -Xmx8g -Xmn4g`"
    : "${JVM_MEMORY:="-Xms2g -Xmx2g -Xmn1g"}"
    sed -i "s/-server -Xms8g -Xmx8g -Xmn4g/${JVM_MEMORY}/g" runbroker.sh
    exec sh mqbroker -n "$2":9876
    ;;
  *)
    # The command is something like bash, not an rocketmq subcommand. Just run it in the right environment.
    exec "$@"
    ;;
esac