#!/bin/bash
while ps aux | grep -v grep | grep -q httpd
do
echo "正在运行中"
done
echo "http is closed"
