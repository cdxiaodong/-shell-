#!/bin/bash
#自动化部署配置sftpd服务器，管理tfp服务器
#这对RHEL|CentOS系统
#本地账户访问FTP的共享目录为/common,其中/common/pub为可上传目录
#匿名账户访问FTP的共享目录为/ar/ftp，其中/var/ftp/pub为可上传目录

#定义变量：显示信息的颜色属性
SUCCESS="echo -en \\033[1;32m" #绿色
FAILURE="echo -en \\033[1;31m" #红色
WARNING="echo -en \\033[1;33m" #黄色
NORMAL="echo -en \\033[1;39m"  #黑色
conf_file=/etc/vsftpd/vsftpd.conf

#####从这里开始先将所有需要的功能都定义为函数#####
#定义脚本的主菜单功能
menu(){
    
}
