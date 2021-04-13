#!/bin/bash
# initialize centOS 
# How to? 
# bash os_setup.sh
# Not work with centOS6 and centOS7. 
# Only work with CentOS8.

# in some case, it's better to use the CentOS-8.3.2011-x86_64-dvd1.iso. 

# For example, 
# mkdir -p /media/CentOS/
# mount -o loop CentOS-8.3.2011-x86_64-dvd1.iso /media/CentOS

# mkdir /etc/yum.repos.d/backup
# mv /etc/yum.repos.d/Cent*.repo /etc/yum.repos.d/backup
# cp /etc/yum.repos.d/backup/CentOS-Linux-Media.repo /etc/yum.repos.d/
# sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/CentOS-Linux-Media.repo
# Then, most of the stuff will be installed from DVD, much faster. 


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


# set hostname
# the default hostname is node01
echo "Set the hostname..."
echo "The default hostname is hpc4you."

export server_name=hpc4you
# backup the original /etc/hosts file
#cp /etc/hosts /etc/hosts.original
hostnamectl  --static set-hostname  ${server_name}
#echo  "127.0.0.1  `hostname`"  >   /etc/hosts 


echo "Please wait for a while ..."
echo "It's a bit long..."
echo ""

mkdir /etc/yum.repos.d/backup
cp /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup
sed -i 's/enabled=0/enabled=1/g' *repo
rm -fr /etc/yum.repos.d/CentOS-Linux-Media.repo


# caution, there is no wget in mini installation
yum -y install wget 
yum -y install epel-release

### install necessary packages
### Maybe some lines are duplicated.
yum -y install hwinfo*
yum -y install psmisc gcc gcc-c++  telnet  unzip vim curl  zip unzip &>/dev/null
yum -y install lrzsz lsof   sysstat dos2unix tree wget file tcpdump dstat fping iotop mtr rsync   expect &>/dev/null
yum -y install make
yum -y install gdb     
yum -y install cmake   
yum -y install git   
yum -y install git-svn 
yum -y install ntfs-3g
yum -y install java
yum -y install clang           
yum -y install clang-analyzer   
yum -y install openmpi openmpi-devel
yum -y install mpich mpich-devel
yum -y install perl-Parallel-ForkManager
yum -y install gcc-gfortran lapack-devel fftw-devel rsync
yum -y install rpm-build openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel
yum -y install hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html
yum -y install libgcrypt*
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
yum -y install libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker
yum -y install mariadb-server mariadb-devel
yum -y install screen tree rename
yum -y install bash-completion

yum -y groupinstall "Development Tools"
yum -y groupinstall "RPM Development Tools"


yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r)
yum -y install kernel-dev*
yum -y install kernel-head*
yum -y install kernel*



yum -y install environment-modules
yum -y install openmpi openmpi-devel
yum -y install mpich mpich-devel
yum -y install perl-Parallel-ForkManager
yum -y install ghostscript
yum -y install p7zip
yum -y install unar
yum -y install zsh
yum -y libXScrnSaver*
yum -y install x11*
yum -y install xorg*
yum -y install libGLU*
yum -y install libXScrnSaver

## may be needed when compiling vasp with intel2019
yum -y install libfabric

## Maybe needed if there is Mellanox 10Gbe network controller installed.
yum -y install infiniband-diags perftest gperf
yum -y groupinstall "Infiniband Support"

systemctl start rdma
systemctl enable rdma


### install 32-bit libs.

yum -y install zlib.i686 #Y already present
yum -y install libpng.i686 #N
yum -y install fontconfig.i686 #N
yum -y install libpng12
yum -y install libjpeg-turbo.i686 #N
yum -y install libXau.i686 #N #N
yum -y install libXdmcp.i686 #N
yum -y install libXpm.i686 #N
yum -y install libxml2.i686 #N
yum -y install gd.i686 #N
yum -y install libXmu.i686 #N
yum -y install motif.i686 #N
yum -y install mesa-libGLU.i686 #N
yum -y install libXaw.i686 libXi.i686 #N #N
yum -y install libcom_err.i686 keyutils-libs.i686 libverto.i686 #N #N #N
yum -y install krb5-libs.i686 #N
yum -y install openssl-libs.i686 #Y (by preceding)
yum -y install ncurses-libs.i686 #N
yum -y install pcre-devel.i686 #N
yum -y install freeglut #N
yum -y install freeglut.i686 #for /usr/lib/libglut.so.3 #N
yum -y install glib2.i686 #N
yum -y install compat-libtiff3.i686 #N
yum -y install glibc*686


## disable firewall and selinux
echo "disable firewall & selinux"
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

systemctl stop firewalld.service
systemctl disable firewalld.service
systemctl disable kdump.service
systemctl enable sshd.service


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

### start GUI without reboot
# systemctl isolate graphical

echo "Well Done. Please reboot the server."
