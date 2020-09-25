#!/bin/bash
### only valid for hpc4you mother OS disk
### the mother OS has been modified to use tuna.repo



yum clean all
yum makecache
yum -y install epel-release

### install necessary packages
### Maybe some lines are duplicated.
yum -y install hwinfo*
yum -y install psmisc gc gcc-c++  telnet  unzip vim curl  zip unzip &>/dev/null
yum -y install lrzsz lsof   sysstat dos2unix tree wget file tcpdump dstat fping iotop mtr rsync   expect &>/dev/null
yum -y install make
yum -y install gdb     
yum -y install cmake   
yum -y install git   
yum -y install git-svn 
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

yum -y install gcc
yum -y install gcc-c++
yum -y install gcc-gfortran
yum -y install compat-gcc-44
yum -y install compat-gcc-44-c++
yum -y install compat-gcc-44-gfortran
yum -y install compat-libf2c-34

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
yum -y libXScrnSaver*
yum -y install x11*
yum -y install xorg*
yum -y install libGLU*

yum -y install *openbabel*

yum -y install libXScrnSaver

## may be needed when compiling vasp with intel2019
yum -y install libfabric

## Maybe needed if there is Mellanox 10Gbe network controller installed.
yum -y install infiniband-diags perftest gperf
yum -y groupinstall "Infiniband Support"
systemctl start rdma
systemctl enable rdma


### install 32-bit libs.
yum -y groupinstall "Compatibility libraries"
yum -y install zlib.i686 #Y already present
yum -y install libpng.i686 #N
yum -y install fontconfig.i686 #N
yum -y install libpng12-1.2.50-10.el7.i686 #N
yum -y install libjpeg-turbo.i686 #N
yum -y install libXau.i686 #N #N
yum -y install libXdmcp.i686 #N
yum -y install libXpm.i686 #N
yum -y install libxml2.i686 #N
yum -y install gd.i686 #N
yum -y install libXmu.i686 #N
yum -y install motif.i686 #N
yum -y install libunwind.i686 #N
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
yum -y install compat-libstdc++-33*
yum -y install compat-libstdc++-33*686
yum install -y redhat-lsb
yum install -y redhat-lsb*i686
yum install -y libstdc++-*
yum install -y compat*686
yum install -y compat*
yum install -y glibc*
yum install -y glibc*686
yum install -y libstdc*686
yum install -y libstdc*
yum install -y compat-libstdc*686
yum install -y redhat-lsb*
yum install -y redhat-lsb*686

yum -y install bash-completion


## disable firewall and selinux
echo "disable firewall & selinux"
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

	systemctl stop firewalld.service
	systemctl disable firewalld.service
	systemctl disable kdump.service
	systemctl enable sshd.service



# enable GUI
# systemctl set-default graphical.target


### start GUI without reboot
# systemctl isolate graphical

yum install -y git
yum install -y gcc make rpm-build libtool hwloc-devel \
      libX11-devel libXt-devel libedit-devel libical-devel \
      ncurses-devel perl postgresql-devel postgresql-contrib python3-devel tcl-devel \
      tk-devel swig expat-devel openssl-devel libXext libXft autoconf automake

# install some other stuff
yum install -y expat libedit postgresql-server \
postgresql-contrib python3 sendmail sudo tcl tk libical

yum -y install sshpass
yum -y install nfs-utils

# install database
yum install mariadb-server mariadb-devel -y

# Install MUNGE on all of the nodes 
yum install -y munge munge-libs munge-devel

# Set the permissions for MUNGE directories on all of the nodes
chown -R munge: /etc/munge/ /var/log/munge/
chmod 0700 /etc/munge/ /var/log/munge/

yum install -y rpm-build gcc openssl openssl-devel libssh2-devel pam-devel numactl numactl-devel 
yum install -y hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel gtk2-devel man2html 
yum install -y libibmad libibumad perl-Switch perl-ExtUtils-MakeMaker

yum install -y htop 

yum install -y gnuplot
yum install -y gmt

yum install -y boost*

yum install -y filezilla
yum install -y readline readline-devel readline-static
yum install -y openssl openssl-devel openssl-static sqlite-devel
yum install -y bzip2 bzip2-devel bzip2-libs zlib zlib-devel

yum install -y pangox-compat-devel libunwind-devel
yum install -y glibc.i686 glibc-devel.i686 libgcc.i686 libstdc++.i686 libstdc++-devel.i686

yum install -y ibXmu-devel mesa-libGL-devel mesa-libGLU-devel mesa-libGLw-devel
yum install -y freeglut-devel libXt-devel libXrender-devel libXrandr-devel
yum -y install libXi-devel libXinerama-devel libX11-devel


# enable exfat support
yum group install 'Development Tools'

yum install fuse-devel gcc autoconf automake git
cd /usr/local/src && git clone https://github.com/relan/exfat.git
cd exfat
autoreconf --install
./configure --prefix=/usr
make && make install
make clean


### install GUI Desktop 
### no desktop in basic OS setup.
yum -y groups install "GNOME Desktop" 
yum -y install curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm


## fonts
yum install wqy-zenhei-fonts
yum -y install cjkuni-uming-fonts
yum -y install gnu-free*fonts
yum -y install google*fonts


Intel2020u1, only the following componets. 
/opt/apps/intel2020u1

   1. Accept and continue [ default ]
   2. [None] Intel Trace Analyzer and Collector 2020 Update 1
   3. [None] Intel Cluster Checker 2019 Update 8
   4. [None] Intel VTune Profiler 2020 Update 1
   5. [None] Intel Inspector 2020 Update 1
   6. [None] Intel Advisor 2020 Update 1
   7. [All] Intel C++ Compiler 19.1 Update 1
   8. [All] Intel Fortran Compiler 19.1 Update 1
   9. [All] Intel Math Kernel Library 2020 Update 1 for C/C++
   10.[All] Intel Math Kernel Library 2020 Update 1 for Fortran
   11.[None] Intel Integrated Performance Primitives 2020 Update 1
   12.[All] Intel Threading Building Blocks 2020 Update 2
   13.[None] Intel Data Analytics Acceleration Library 2020 Update 1
   14.[All] Intel MPI Library 2019 Update 7
   15.[None] GNU* GDB 8.3
   16.[None] Intel(R) Distribution for Python*

 Install location:
    /opt/apps/intel2020u1


The following components will be installed:
    Intel C++ Compiler 19.1 Update 1                                       1.2GB
        Intel C++ Compiler                                                 1.1GB

    Intel Fortran Compiler 19.1 Update 1                                   436MB
        Intel Fortran Compiler                                             435MB

    Intel Math Kernel Library 2020 Update 1 for C/C++                      1.9GB
        Intel MKL core libraries for C/C++                                  10MB
        Cluster support for C/C++                                           11MB
        Intel TBB threading support                                         54MB
        PGI* C/C++ compiler support                                         11MB
        GNU* C/C++ compiler support                                         74MB

    Intel Math Kernel Library 2020 Update 1 for Fortran                    1.8GB
        Intel MKL core libraries for Fortran                                 6MB
        Cluster support for Fortran                                          7MB
        GNU* Fortran compiler support                                      145MB
        Fortran 95 interfaces for BLAS and LAPACK                           33MB

    Intel Threading Building Blocks 2020 Update 2                          139MB
        Intel TBB                                                          124MB

    Intel MPI Library 2019 Update 7                                        1.0GB
        Intel MPI Benchmarks                                                 2MB
        Intel MPI Library for applications running on Intel(R) 64 Architecture 1.0GB

   Install space required:  4.2GB


--------------------------------------------------------------------------------
Install location:
    /opt/apps/intel2019u5

Component(s) selected:
    Intel C++ Compiler 19.0 Update 5                                       840MB
        Intel C++ Compiler

    Intel Fortran Compiler 19.0 Update 5                                   331MB
        Intel Fortran Compiler

    Intel Math Kernel Library 2019 Update 5 for C/C++                      1.9GB
        Intel MKL core libraries for C/C++
        Cluster support for C/C++
        Intel TBB threading support
        PGI* C/C++ compiler support
        GNU* C/C++ compiler support

    Intel Math Kernel Library 2019 Update 5 for Fortran                    1.8GB
        Intel MKL core libraries for Fortran
        Cluster support for Fortran
        GNU* Fortran compiler support
        Fortran 95 interfaces for BLAS and LAPACK

    Intel Threading Building Blocks 2019 Update 8                           59MB
        Intel TBB

    Intel MPI Library 2019 Update 5                                        806MB
        Intel MPI Benchmarks 2019 Update 4
        Intel MPI Library for applications running on Intel(R) 64 Architecture

   Install space required:  3.8GB

Installation Target:
    Install on the current system only

--------------------------------------------------------------------------------

   #### Install scl gcc9
   yum -y install centos-release-scl
   yum -y install devtoolset-9






### cmake 3 installed to 
## /opt/apps/cmake-3.14.0-Linux-x86_64

## GNU MPI versions
# mpi/mpich-3.0-x86_64 mpi/mpich-x86_64     mpi/openmpi3-x86_64  mpi/openmpi-x86_64
module load mpi/openmpi-x86_64

module load mpi/openmpi3-x86_64
module load mpi/mpich-3.0-x86_64


## the following boost versions are OK




