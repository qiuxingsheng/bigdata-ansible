#!/bin/bash
HIVE_LOG_DIR=$HIVE_HOME/logs
if [ ! -d $HIVE_LOG_DIR ]
then
  mkdir -p $HIVE_LOG_DIR
fi
# 检查进程是否运行正常，参数1为进程名，参数2为进程端口
function check_process() {
    pid=$(ps -ef 2>/dev/null | grep -v grep | grep -i $1 | awk '{print $2}')
    ppid=$(netstat -ntlp 2>/dev/null | grep $2 | awk '{print $7}' | cut -d '/' -f 1)
    echo $pid
    [[ "$pid" =~ "$ppid" ]] && [ "$ppid" ] && return 0 || return 1
}

function hive_start() {
    server2pid=$(check_process HiveServer2 10000)
    cmd="nohup hiveserver2 >$HIVE_LOG_DIR/hiveserver2.log 2>&1 &"
    [ -z "$server2pid" ] && eval $cmd || echo "HiveServer2服务已启动"
}

function hive_stop() {
    server2pid=$(check_process HiveServer2 10000)
    [ "$server2pid" ] && kill $server2pid || echo "HiveServer2服务未启动"
}

case $1 in
"start")
  hive_start
  ;;
"stop")
  hive_stop
  ;;
"restart")
  hive_stop
  sleep 2
  hive_start
  ;;
"status")
  check_process HiveServer2 10000 >/dev/null && echo "HiveServer2服务运行正常" || echo "HiveServer2服务运行异常"
  ;;
"*")
  echo "Invalid Args!"
  echo "Usage: '$(basename $0)' start|stop|restart|status"
  ;;
esac
