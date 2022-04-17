#!/bin/bash
#编写脚本抓取单个网页中的图片数据
#需要抓去数据的网页链接和种子URL文件名
page="http://www.tmooc.cn"
URL="/tmp/spider_$$.txt"

#将网页源码保存到文件中
curl -s http://www.tmooc.cn/ > $URL

#对文件进行过滤和清洗，获取需要的种子url链接
echo -e "\033[32m正在获取种子URL，请稍后...\033[0m"
sed -i '/<imge/!d' $URL      #删除不包含<img的行
sed -i 's/.*src="//' $URL    #删除SRC”及前面的所有内容
sed -i 's/".*//' $URL        #删除双引号及其后面的所有内容
echo

#利用循环批量下载所有图片数据
# -p制定将数据下载到特定目录（prefix）
# -c支持断点续传
# -q不显示下载过程（quiet）
echo -e "\033[32m正在批量下载种子数据，请稍后....\033[0m"
for i in $(cat URL)
do
  wget -p /tmp/ -c -q $i
done

#删除临时种子列表文件
rm -rf $URL




