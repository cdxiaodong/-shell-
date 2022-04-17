#!/bin/bash
#功能:每当创建sh文件时，自动在最顶部添加#!/bin/bash
#判断文件中是否存在#!
#使用EOF添加数据
if ! grep "^#!" "$1" &>/dev/null;
then
    cat > "$1" << EOF
#!/bin/bash
EOF
fi
chmod 777 $1
nano "$1"

#记得建立软连接,在ternalm执行下面指令 
#sudo ln -s $(pwd)/na.sh /usr/bin/na 
