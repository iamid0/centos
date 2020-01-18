#!/bin/bash
# initialize centOS 
# How to? 
# bash os_setup.sh
# maybe not work with centOS6


Date1=`date +'%F-%H:%M'`

##
if [ $# != 0 ]
then
echo -e "\033[41;34m ERROR , check the shell log , bash -x $0 Tag \033[0m"
exit 0
fi

## if not root, abort
if [ "$USER" != root ];then
        echo "Please login as root, and try again!!!"
        exit 1
fi

OS_VERSION=`cat /etc/system-release | awk '{print $(NF-1)}' | awk -F"." '{print $1}' `

# set hostname
# the default hostname is node01
echo "Set the hostname..."
echo "The default hostname is node01."

server_name=node01

if [ "$OS_VERSION" -eq 6 ];then
	echo -e "NETWORKING=yes\nHOSTNAME=${Hostname}" >/etc/sysconfig/network

else
	hostnamectl  --static set-hostname  ${server_name}
    echo  "127.0.0.1  `hostname`"  >   /etc/hosts 
fi

### setupyum source 
mkdir /etc/yum.repos.d/backup
mv /etc/yum.repos.d/Cent*.repo /etc/yum.repos.d/backup
#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
if [ "$OS_VERSION" -eq 6 ];then
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
elif [ "$OS_VERSION" -eq 7 ];then
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
elif [ "$OS_VERSION" -eq 8 ];then
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
fi
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
yum clean all
yum makecache
yum -y install epel-release

### install necessary packages
yum install psmisc gc gcc-c++  telnet  unzip vim curl  zip unzip -y  &>/dev/null
yum install lrzsz lsof   sysstat dos2unix tree wget file tcpdump dstat fping iotop mtr rsync   expect  -y &>/dev/null
yum -y install make
yum -y install gdb     # 代码调试器
yum -y install cmake   # Cmake
yum -y install git     # 版本控制
yum -y install git-svn # git的svn插件
yum -y install ntfs-3g
yum -y install java
yum -y install clang             # clang编译器
yum -y install clang-analyzer    # clang静态分析器
yum -y install openmpi openmpi-devel
yum -y install mpich mpich-devel
yum -y install perl-Parallel-ForkManager
yum -y install gcc-gfortran gcc-g++ lapack-devel fftw-devel openmpi3-devel wget rsync
yum -y install rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel
yum -y install hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html
yum -y install libgcrypt*
yum -y install python2-cryptography*
yum -y install readline-devel
yum -y install pam-devel
yum -y install libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker
yum -y install glibc.i686
yum -y install libgcrypt*
yum -y install python2-cryptography*
yum -y install readline-devel
yum -y install pam-devel
yum -y install munge-devel
yum -y install munge-libs
yum -y install rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel
yum -y install hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html
yum -y install libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker
yum -y install mariadb-server mariadb-devel
yum -y install screen tree rename
yum -y groupinstall "Development Tools"
yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
yum -y install kernel-dev*
yum -y install kernel-head*
yum -y install kernel*
yum -y install epel-release
yum -y install gcc
yum -y install gcc-c++
yum -y install gcc-gfortran
yum -y install compat-gcc-44
yum -y install compat-gcc-44-c++
yum -y install compat-gcc-44-gfortran
yum -y install compat-libf2c-34
yum -y install make
yum -y install gdb
yum -y install cmake
yum -y install git
yum -y install ntfs-3g
yum -y install java
yum -y install clang
yum -y install clang-analyzer
yum -y install environment-modules
yum -y install openmpi openmpi-devel
yum -y install mpich mpich-devel
yum -y install perl-Parallel-ForkManager
yum -y install python-matplotlib
yum -y install python-matplotlib
yum -y install PyQt4
yum -y install numpy
yum -y install scipy
yum -y install python-requests
yum -y install python-docopt
yum -y install gdal-pythons
yum -y install zathura zathura-plugins-all
yum -y install ghostscript
yum -y install p7zip
yum -y install unar
yum -y install zsh




if [ "$OS_VERSION" -ne 7 ];then
       yum -y install bash-completion
fi

## disable firewall and selinux
echo "disable firewall & selinux"
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0
if [ "$OS_VERSION" -eq 6 ];then
	servcie iptables stop
	chkconfig iptables off
	chkconfig sshd on	
else
	systemctl stop firewalld.service
	systemctl disable firewalld.service
	systemctl disable kdump.service
	systemctl enable sshd.service
fi

### disable GUI
echo -e "Enable GUI or no GUI? y/n"
echo -e "Please input y or n"
read check

if [ ${check} = n ]
then
	echo "Disable GUI"
systemctl set-default multi-user.target

elif [ ${check} = y ]
then
echo "enable GUI"
systemctl set-default graphical.target
fi


