#!/bin/bash
ansible-playbook  /data/ansible/role_master.yml
# 安装+配置环境变量
ansible-playbook  /data/ansible/role_jdk8.yml
ansible-playbook  /data/ansible/role_zookeeper.yml
ansible-playbook  /data/ansible/role_hadoop.yml
# ↓↓↓ 需要设置数据库地址账号密码 ↓↓↓
ansible-playbook  /data/ansible/role_mysql.yml
ansible-playbook  /data/ansible/role_spark.yml
ansible-playbook  /data/ansible/role_hive.yml
ansible-playbook  /data/ansible/role_azkaban.yml
# ↑↑↑ 需要设置数据库地址账号密码 ↑↑↑
# datax
ansible-playbook  /data/ansible/role_datax.yml
ansible-playbook  /data/ansible/role_sqoop.yml
ansible-playbook  /data/ansible/role_py_exec.yml

# trino
ansible-playbook  /data/ansible/role_trino.yml
