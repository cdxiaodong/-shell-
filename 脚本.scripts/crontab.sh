#!/bin/bash
echo "
例子: 
* * * * * command 每分钟执行一次
3,15 * * * * command 每小时的第3和第15分钟执行
* */1 * * * command 每一小时执行一次
* 23-7/1 * * * command 晚上11点到早上7点之间，每隔一小时执行一次
3,15 8-11 */2 * * command 每隔两天的上午8点到11点的第3和第15分钟执行
3,15 8-11 * * 1 command 每个星期一的上午8点到11点的第3和第15分钟执行

注意:
在 crontab 文件中定义多个调度任务时，需要特别注意的一个问题就是环境变量的设置，
如果文件的话最好是完整地址
或者 提前
ln -s $(pwd)/na.sh /usr/bin/na     然后直接 * * * * * na
export na="/home/cdxiaodong/2.sh"  然后直接 * * * * * na

"
read -p "请输入分钟信息(00-59):" min
read -p "请输入小时信息(00-59):" hour
read -p "请输入日期信息(00-59):" date
read -p "请输入月份信息(00-59):" month
read -p "请输入星期信息(00-59):" weak
read -p "请输入计划任务需要执行的命令或脚本:" program
echo "$min $hour $date $month $weak $program &>/dev/null" >> /etc/crontab
