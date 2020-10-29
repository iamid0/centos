#!/bin/bash

# get CPU number
cpu_num=`cat /proc/cpuinfo | grep 'processor' | wc -l `
# export x=${cpu_num}
export x=$((${cpu_num}*4))

echo -e "I will start \033[1;31m ${x}\033[0;35m\033[0m threads to run SuperPI."
echo -e "\033[1;31mNeeds several hours, maybe. \033[0;35m\033[0m"
echo -e "\033[1;32mPress Enter to continue. \033[0;35m\033[0m"
echo -e "\033[1;33mReboot server to stop SuperPI, \033[0;35m\033[0m"
echo -e "Or run \033[1;34m pkill -9 bc \033[0;35m\033[0m as root user."
echo -e "\033[1;30mIf your server dies in the first 30 minutes, then ask the seller for money back.\033[0;35m\033[0m"


while [ ${x} -gt 0 ]
do 

echo "scale = 80000 ; 4*a(1)" | bc -l -q > /dev/null 2>&1 &
x=$((${x}-1))

done
