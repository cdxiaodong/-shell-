#!/bin/bash
#河北抓包
#新建一个文件容器
mkdir jpg &>/dev/null
mkdir tmp &>/dev/null
touch /tmp/tmp.txt

#文件赋值
tmpfile="/tmp/tmp.txt"
curl -s https://www.hntv.tv > $tmpfile

#数据操作
#url=$(awk '/href/' $tmpfile)
#变成这样
# <a href="https://www.hntv.tv/rhh-6091552768/article/1/1510891523102310402?v=1.0" target="_blank">
# <h5 class="f16 lh28 mrg-t-10 dot7 dot"><a href="https://www.hntv.tv/rhh-6091552768/article/1/1510891523102310402?v=1.0" target="_blank">请收下这份春日礼物！百万郁金香一次看个够</a></h5>
#可以看到这两个链接是一样的;所以说他们虽然在每一列的不同位置，但是我们只要选取其中一列就行了
#可以以“为分隔符将所有组件提权出来 再用 https匹配
url=$(awk -F\" '/href/&&/https/{print $2}' $tmpfile | awk '/https/')
#将参数转存到文件中
echo $url > movie.txt
#后面发现这个链接下面的视频也是个项目栏。真正的视频应该在源码里面
#但是在源码里面官方把接口给弄没了


#接下来弄图片
#jpg=$(awk -F\" '/src/&&/jpg/{print $4}' $tmpfile)
#但是这样会有重复、需要删除、可以将其弄到文件、然后在读取、再删除、以防止不能直接对参数做处理
#当然直接使用uniq更方便
 jpg=$(awk -F\" '/src/&&/jpg/{print $4}' $tmpfile | uniq)  
echo $jpg > jpg.txt

#读取每行链接并下载
cat jpg.txt | while read line
do
wget -P /jpg $line 
done


rm -rf $tmpfile
