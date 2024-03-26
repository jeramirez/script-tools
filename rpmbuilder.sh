#!/bin/bash

PACKAGE=xrootd-hdfs
VERSION=2.2.0.1.1
RELEASETAG=1
RELEASERPM=1

#Don't know how to change it
RPMBUILDROOT=$HOME/rpmbuild
#RPMBUILDROOT=/scratch/plugins/test/rpmbuild
#export RPM_BUILD_ROOT=$RPMBUILDROOT

#Download bigtop repo (1.5.0)
#[ -f ./bigtop.repo ]||wget https://archive.apache.org/dist/bigtop/bigtop-1.5.0/repos/centos-7/bigtop.repo
#Download bigtop repo (3.2.1)
[ -f ./bigtop.repo ]||wget https://dlcdn.apache.org/bigtop/bigtop-3.2.1/repos/centos-7/bigtop.repo

#install building requirements
#get /usr/include/hdfs.h
[ -f /usr/include/hdfs.h ]||yum -y --config=./bigtop.repo --enablerepo=bigtop install hadoop-libhdfs-devel
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
