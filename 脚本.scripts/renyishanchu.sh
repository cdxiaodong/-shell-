#!/bin/bash
read -p "请输入一个目标文件:" wenjian
whereis $wenjian | xargs -n1 >> 1.txt
find . -name "$wenjian" >> 1.txt 
awk '/\//' 1.txt > 2.txt
cat 2.txt | while read line
do
ls -i $line | xargs -n1 >> 3.txt
done
sed -n '1~2p' 3.txt > 4.txt

cat 4.txt | while read line1
do
find . -inum $line1 -delete
done

rm 1.txt
rm 2.txt
rm 3.txt
rm 4.txt
#基于inode删除任意文件