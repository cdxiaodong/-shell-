#!/bin/bash
rm 100.txt &>/dev/null
rm 99.txt &>/dev/null
touch 100.txt
tmpfile="100.txt"
touch 99.txt


#还没写= = 因为申请api有点贵 一个脚本不值得 cry
#有需求的兄弟可以自己注册自己写 或者注册完之后联系1397685307@qq.com我帮你写
function translate() {

}

#之前的可以一比一翻译的 但是api已经用不了了
#!/bin/bash
#Verson:2.8
#Pragram:This is a chinese-english translation scripts.
    # TMP=$(mktemp /tmp/tmp.XXXXXXXX)
    # URL='http://fanyi.youdao.com/openapi.do?keyfrom=<keyfrom>&key=<key>&type=data&doctype=<doctype>&version=1.1&q='
    # wget -q  -O $TMP  "$URL$*"

    # if  cat $TMP | grep  '\<ex\>' &>/dev/null  ;then
    #     cat $TMP | grep -Po '(?<=\<ex\>\<\!\[CDATA).*(?=\]\>)'   | head -1
    # else
    #     cat $TMP | grep -Po '(?<=\<paragraph\>\<\!\[CDATA).*(?=\]\>)' | head -1
    # fi

    # rm $TMP
    # unset TMP URL  

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

read -p "请输入要翻译文件的总目录:" mulu
path=("/"$mulu)
read_dir $path
cat 100.txt | awk '/\.c/||/\.h/' > 99.txt  #后面按照这个格式自己加  


function fanyi() {
#先做一条行的
#试试if判断多行
cat $1 | while read line
let hang+=1
do
  grep "\/\*" $line &>/dev/null
  if [ $? = 0 ]; then 
     #读取单行
     grep "\*\/" $line &>/dev/null
     if [ $? = 0 ]; then
        #匹配出字符并带出给翻译脚本 
        awk -F"\/\*" '{print $2}' $line > 1.txt
        o=$(sed 's#\*\/##' 1.txt)
        j=$(translate $o)
        rm 1.txt
        #用sed替换字符
        sed -r -i "s#(\/\*)(.*)(\*\/)#\1\'$j'\3#" $line
    else
        #2.是多行
        let hou $hang+10
        #截取之后十行
        sed -n ""$hang","$hou"p" bashhist.c > 2.txt
        #将所有行变成一行
        awk BEGIN{RS=EOF}'{gsub(/\n/," ");print}' 2.txt > 3.txt
        awk -F"\/\*" '{print $2}' $line > 1.txt
        o=$(sed 's#\*\/##' 3.txt)
        j=$(translate $o)
        #直接在匹配的前一行添加我们的翻译
        #注意那个&符号 这个就是我们在行前添加的符号
        sed -r -i "s#(\/\*)(.*)#\/\*'$j'\*\/&#" $line
        rm 1.txt
        rm 2.txt
        rm 3.txt
     fi 
  fi
done
}

cat 99.txt | while read line99
do
  fanyi line99
done

rm 100.txt
rm 99.txt
echo "-----------------------翻译完成---------------------------------"