#!/bin/bash

# get CPU number
cpu_num=`cat /proc/cpuinfo | grep 'processor' | wc -l `


echo -e "I will start \033[1;31m ${cpu_num}\033[0;35m\033[0m threads to run SuperPI."
echo -e "\033[1;31m Needs several hours, maybe. \033[0;35m\033[0m"

export x=${cpu_num}

while [ ${x} -gt 0 ]
do 

echo "scale = 80000 ; 4*a(1)" | bc -l -q &
x=$((${x}-1))

done
