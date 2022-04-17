#!/bin/bash
hi="hello"
echo "+++++++++++++++++++++++++++++"
echo "+    iam dadshell     +"
echo "+++++++++++++++++++++++++++++"
echo "PWD=$PWD"
echo "bash_subshell=$BASH_SUBSHELL"
#通过（）开启子shell
(
sub_hi="I am a subshell"
echo -e "\t+++++++++++++++"
echo -e "\t+ into subshell +"
echo -e "\t+++++++++++++++"
echo -e "\tPWD=$PWD"
echo -e "\tbash_subshell=$BASH_SUBSHELL"
echo -e "\thi=$hi"
echo -e "\tsub_hi=$sub_hi"
cd /etc;echo -e "\tPWD=$PWD"
)

echo "++++++++++++++"
echo "+ returnto dadshell     +"
echo "+++++++++++++++++"
echo "PWD=$PWD"
echo "hi=$hi"
echo "sub_hi=$sub_hi"
echo -e "bash_subshell=$BASH_SUBSHELL"


