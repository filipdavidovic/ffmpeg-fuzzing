#!/usr/bin/env bash

# colors for the terminal
export GREEN=`tput setaf 2`
export CYAN=`tput setaf 6`
export RED=`tput setaf 1`
export NC=`tput sgr0` # No Color

function echo_info {
    echo "${GREEN}${1}${NC}"
}

# create the findings directory if it doesn't exist
[ ! -d /vagrant/findings ] && mkdir /vagrant/findings

# install dependencies
echo_info "[+] Cleaning and updating apt-get"
apt-get clean -qq
apt-get update -qq
echo_info "[+] Installing dependencies needed to compile ffmpeg"
apt-get install -y -qq \
  autoconf \
  automake \
  build-essential \
  cmake \
  git-core \
  libass-dev \
  libfreetype6-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  pkg-config \
  texinfo \
  wget \
  zlib1g-dev \
  nasm
echo_info "[+] Installing American Fuzzy Loop"
apt-get install -y -qq afl

echo_info "[+] Compiling ffmpeg to use with AFL"
mkdir /home/vagrant/bin /home/vagrant/ffmpeg_sources
cd /home/vagrant/ffmpeg_sources
echo_info " [-] Download current ffmpeg source"
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
echo_info " [-] Unpacking ffmpeg source"
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
echo_info " [-] Configuring ffmpeg install"
./configure --prefix=/home/vagrant/bin
echo_info " [-] Compiling ffmpeg with afl-gcc"
make CC=afl-gcc
echo_info " [-] Installing ffmpeg"
make install
echo core >/proc/sys/kernel/core_pattern # needed for AFL

echo_info "[!] ffmpeg binaries ready to be used with AFL are located in /home/vagrant/bin/bin"
echo_info "[!] Done."