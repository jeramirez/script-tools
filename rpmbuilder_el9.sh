#!/bin/bash

PACKAGE=xrootd-hdfs
VERSION=2.2.3
RELEASETAG=1
RELEASERPM=1

#new to alma9
export JVM_INCLUDE_DIR=/usr/lib/jvm/java-1.8.0/include/
export JVM_LIB_DIR=/usr/lib/jvm/jre-1.8.0/lib
export JVM_LIB_DIR=/usr/lib/jvm/jre-1.8.0/lib/amd64/server

#Don't know how to change it
RPMBUILDROOT=$HOME/rpmbuild
#RPMBUILDROOT=/scratch/plugins/test/rpmbuild
#export RPM_BUILD_ROOT=$RPMBUILDROOT

#Download bigtop repo (1.5.0)
#[ -f ./bigtop.repo ]||wget https://archive.apache.org/dist/bigtop/bigtop-1.5.0/repos/centos-7/bigtop.repo
#Download bigtop repo (3.2.1)
#[ -f ./bigtop.repo ]||wget https://dlcdn.apache.org/bigtop/bigtop-3.2.1/repos/centos-7/bigtop.repo

##
#  install hadoop-libhdfs-devel (local rpms)
##
#dnf install almalinux-release-devel
#edit repo to disable devel by default
#dnf --enablerepo=devel install redhat-lsb-core
#cd ~/bigtop/build/hadoop/rpm/RPMS/x86_64
#~/bigtop/build/bigtop-groovy/rpm/RPMS/noarch/bigtop-groovy-2.5.4-1.el9.noarch.rpm 
#~/bigtop/build/bigtop-jsvc/rpm/RPMS/x86_64/bigtop-jsvc-1.2.4-1.el9.x86_64.rpm 
#~/bigtop/build/bigtop-utils/rpm/RPMS/noarch/bigtop-utils-3.3.0-1.el9.noarch.rpm 
#~/bigtop/build/zookeeper/rpm/RPMS/x86_64
dnf -y  install \
hadoop-libhdfs-devel-3.3.6-1.el9.x86_64.rpm \
hadoop-libhdfs-3.3.6-1.el9.x86_64.rpm \
hadoop-hdfs-3.3.6-1.el9.x86_64.rpm \
hadoop-3.3.6-1.el9.x86_64.rpm \
bigtop-groovy-2.5.4-1.el9.noarch.rpm \
bigtop-jsvc-1.2.4-1.el9.x86_64.rpm \
bigtop-utils-3.3.0-1.el9.noarch.rpm \
zookeeper-3.7.2-1.el9.x86_64.rpm

#install building requirements
#get /usr/include/hdfs.h
#[ -f /usr/include/hdfs.h ]||yum -y --config=./bigtop.repo --enablerepo=bigtop install hadoop-libhdfs-devel
#using local install above#[ -f /usr/include/hdfs.h ]||source $HOME/install-hadoop-libhdfs-devel.sh
[ -f /usr/bin/cmake ]||yum -y install cmake
[ -f /usr/bin/jvmjar ]||yum -y install jpackage-utils
[ -f /usr/include/zlib.h ]||yum -y install zlib-devel
[ -f /usr/lib/jvm/java/include/jni.h ]||yum -y install java-devel
[ -f /usr/include/openssl/crypto.h ]||yum -y install openssl-devel
[ -f /usr/include/xrootd/XrdVersion.hh ]||yum -y --enablerepo=epel install xrootd-devel
[ -f /usr/include/xrootd/XrdAcc/XrdAccAuthorize.hh ]||yum -y --enablerepo=epel install xrootd-server-devel

[ -d $RPMBUILDROOT ]||echo no $RPMBUILDROOT, creating
[ -d $RPMBUILDROOT ]||mkdir $RPMBUILDROOT
[ -d $RPMBUILDROOT/SPECS ]||echo no $RPMBUILDROOT/SPECS, creating
[ -d $RPMBUILDROOT/SPECS ]||mkdir $RPMBUILDROOT/SPECS
[ -d $RPMBUILDROOT/SOURCES ]||echo no $RPMBUILDROOT/SOURCES, creating
[ -d $RPMBUILDROOT/SOURCES ]||mkdir $RPMBUILDROOT/SOURCES

rpm -f $RPMBUILDROOT/SPECS/${PACKAGE}.spec
wget -O $RPMBUILDROOT/SPECS/${PACKAGE}.spec https://raw.githubusercontent.com/jeramirez/$PACKAGE/v$VERSION/rpm/xrootd-hdfs.spec

#remove current source
rm -f $RPMBUILDROOT/SOURCES/${PACKAGE}-${VERSION}.tar.gz
wget -O $RPMBUILDROOT/SOURCES/${PACKAGE}-${VERSION}.tar.gz https://github.com/jeramirez/$PACKAGE/archive/refs/tags/v$VERSION.tar.gz

#make rpm
#don't work as expected#rpmbuild -bb  --buildroot $RPMBUILDROOT $RPMBUILDROOT/SPECS/${PACKAGE}.spec
rpmbuild -bb  $RPMBUILDROOT/SPECS/${PACKAGE}.spec
