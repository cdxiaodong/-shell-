#!/bin/bash
COMMAND=$*
HOST_INFO=host_info
for IP in $(awk '/^[^#]/{print $1}' $HOST_INFO); do #^#代表任意数字
    USER=$(awk -v ip=$IP 'ip==$1{print $2}' $HOST_INFO)
    PORT=$(awk -v ip=$IP 'ip==$1{print $3}' $HOST_INFO)
    PASS=$(awk -v ip=$IP 'ip==$1{print $4}' $HOST_INFO)
    #这里expect可能本地没有安装 需要安装一下
    expect -c "
      spawn ssh -p $PORT $USER@$IP
      expect {
        \"(yes/no)\" {send \"yes\r\"; exp_continue}
        \"password:\" {send \"$PASS\r\"; exp_continue}
        \"$USER@*\" {send \"$COMMAND\r exit\r\"; exp_continue}
    }
    "
    echo "-----------------------------------"
done