#!/bin/bash
echo "pls choose a session under the hint"
select item in "CPU" "IP" "MEM" "exit"
do
case $item in
"CPU")
   uptime;;
"IP")
   ip a s;;
"MEM")
   free;;
"exit")
   exit;;
*)
   echo error;;
  esac
done

