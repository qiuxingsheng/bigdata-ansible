#!/bin/bash
pName=$(rpm -qa | grep "java")
if [ $? -eq 0 ]
then
  echo "软件包"${pName}"已经安装。"
  rpm -e --nodeps java
fi
