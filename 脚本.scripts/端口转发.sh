#!/bin/bash

echo "正在检测本地有何软件----------------------"
echo "有iptables"

lcx &>/dev/null
if [ $? = 0 ];then
echo "有lcx"
else
echo "无lcx"
fi

rineted &>/dev/null
if [ $? = 0 ];then
echo "有rinetd"
else
echo "无rinetd"
fi

echo "
使用方法:
1.iptables
2.rinetd
3.lcx
"

read -p "请输入序号" xuhao
if [ $xuhao = 1 ];then
#iptables
#  linux的IP转发功能是默认关闭的，而且根据很多安全加固策略以及安全基线的要求，
#  IP转发功能必须关闭，所以需要先打开IP转发。
#  需要长期使用的话则写入到sysctl的配置文件中。
echo 1 >/proc/sys/net/ipv4/ip_forward &>/dev/null
sysctl -w /etc/sysctl.conf &>/dev/null
service iptables stop &>/dev/null
#配置iptables，在PERROUTING链中做DNAT。需要长期使用的话需要注意保存配置。
echo "是否需要清空iptables表  1.要 2.否 (输入序号)" qingkong
    case $qingkong in
    1)
    iptables -F -t nat
    esac
echo "选择连接类型  1.远程 2.本地 (输入序号)" lianjie
    if [ $lianjie == 1 ];then
    read -p "远程连接 格式 本地接口ip(123.123.123.123) 本地port(3389)  远程ip+port(110.110.110.110:3389):
    键盘输入格式 “ip port ip+port“ 中间有空格 务必在同一行
    所有访问防火墙z 端口的请求都转发给后端的x 的y 端口
    iptables -t nat -A PREROUTING -p tcp -i eth0 -d $x --dport $y -j DNAT --to $z
    " x y z
    iptables -t nat -A PREROUTING -p tcp -i eth0 -d $x --dport $y -j DNAT --to $z
    service iptables save
    fi
    if [ $lianjie == 2 ];then
    read -p "本地连接 格式 本地接口ip(123.123.123.123) 本地port(3389)  本地另一个网卡(也可以同网卡)ip+port(110.110.110.110:3389):
    键盘输入格式 “ip port ip+port“ 中间有空格 务必在同一行
    iptables -t nat -A OUTPUT -p tcp -d 192.168.4.177 --dport 80 -j DNAT --to 127.0.0.1:8080
    " a b c
    iptables -t nat -A OUTPUT -p tcp -d $a --dport $b -j DNAT --to $c
    service iptables save
    fi
fi

if [ $xuhao = 2 ];then
# wget http://www.boutell.com/rinetd/http/rinetd.tar.gz  -P /usr/local
# tar -zxvf rinetd.tar.gz
#  make && make install
#命令格式
#bindaddress bindport connectaddress connectport
read -p "
输入格式(记得 a b c d 同一行 以空格为界 而不是回车)
本地ip(a) 本地端口(b) 远程ip(c) 远程端口(d)
将a的b端口映射为c的d端口
" a b c d
cat >> /etc/rinetd.conf << EOF
$a $b $c $d
EOF
echo "rinetd -c /etc/rinetd.conf" >> /etc/rc.local
fi

if [ $xuhao = 3 ];then
read -p "格式
肉鸡上执行 lcx.exe -slave 公网 ip(a) + 端口(b) 肉鸡 ip(c) + 端口(d)
" a b c d
lcx.exe -slave $a $b $c $d
fi
