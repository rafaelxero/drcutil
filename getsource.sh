#!/usr/bin/env bash

source config.sh

sudo apt-get -y install git subversion

get_source() {
    if [ ! -e $2 ]; then
	$1 $2
    fi
}

if [ ! -e $SRC_DIR ]; then
  mkdir -p $SRC_DIR 
fi

cd $SRC_DIR

get_source "svn co http://svn.openrtm.org/OpenRTM-aist/branches/RELENG_1_1/OpenRTM-aist" OpenRTM-aist
get_source "git clone https://github.com/fkanehiro/openhrp3.git" openhrp3
get_source "git clone https://github.com/isri-aist/hrp2" HRP2
get_source "git clone https://github.com/isri-aist/hrp2kai" HRP2KAI
get_source "git clone https://github.com/isri-aist/hrp5p" HRP5P
get_source "git clone https://github.com/isri-aist/hrpsys-private" hrpsys-private
get_source "git clone --recursive https://github.com/isri-aist/hrpsys-state-observation" hrpsys-state-observation

get_source "git clone https://github.com/fkanehiro/hrpsys-base" hrpsys-base
get_source "git clone --recursive https://github.com/mehdi-benallegue/state-observation" state-observation
get_source "git clone https://github.com/jrl-umi3218/hmc2" hmc2
get_source "git clone https://github.com/jrl-umi3218/hrpsys-humanoid" hrpsys-humanoid
get_source "git clone --recursive https://github.com/mehdi-benallegue/sch-core" sch-core
if [ "$ENABLE_SAVEDBG" -eq 1 ]; then
    get_source "git clone https://github.com/isri-aist/savedbg" savedbg
fi
if [ "$INTERNAL_MACHINE" -eq 0 ]; then
    if [ "$DIST_VER" != "16.04" ]; then
	if [ ! -e octomap-$OCTOMAP_VERSION ]; then
	    wget https://github.com/OctoMap/octomap/archive/v$OCTOMAP_VERSION.tar.gz
	    tar zxvf v$OCTOMAP_VERSION.tar.gz
	fi
    fi
    GIT_SSL_NO_VERIFY=1 get_source "git clone https://choreonoid.org/git/choreonoid.git" choreonoid
    cd choreonoid/ext
    get_source "git clone https://github.com/jrl-umi3218/hrpcnoid" hrpcnoid
    cd ../..
    if [ "$BUILD_TRAP_FPE" -eq 1 ]; then
	if [ ! -e DynamoRIO-$DYNAMORIO_VERSION.tar.gz ]; then
	    wget https://github.com/DynamoRIO/dynamorio/releases/download/$DYNAMORIO_RELEASE/DynamoRIO-$DYNAMORIO_VERSION.tar.gz
	fi
	get_source "git clone https://bitbucket.org/jun0/trap-fpe" trap-fpe
    fi
else
    get_source "git clone https://github.com/gbiggs/flexiport" flexiport
    get_source "git clone https://github.com/fkanehiro/hokuyoaist" hokuyoaist
    get_source "git clone https://github.com/fkanehiro/rtchokuyoaist" rtchokuyoaist
fi
