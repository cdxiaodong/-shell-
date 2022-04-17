#!/bin/bash
key="avcdefghijklnmopqrstuvwxyzABCDEFGHIJKLNMOPQRSTUVWXYZ0123456879"
randpass(){
  if [ -z "$1" ];then
     echo "randpass 函数需要一个参数，用来制定提取的随机数个数"
     return 127
  fi
  pass=""
  for i in 'seq $1'
  do 
     num=$[RANDOM%${#key}]
     local tmp=${key:num:1}
     pass=${pass}${tmp}
  done
echo $pass
}
#创建临时测试账户，为账户配置随机密码，并将密码保存至/tmp/pass.log
useradd tomcat
passwd=${randpass 6}
echo $passwd | passwd --stdin tomcat
echo $passwd > /tmp/pass.log
