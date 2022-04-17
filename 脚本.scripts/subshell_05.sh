#!/bin/bash
pstree
bash /root/env.sh
echo "passwd=$password"
echo "Error:$error_info"

source /root/env.sh
echo "passwd=$password"
echo "Error:$error_info"
