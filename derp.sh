#!/bin/bash

# mkdir -p cc
# mkdir -p c
# # Set default values for device and commandd
# wget https://github.com/ccache/ccache/releases/download/v4.10/ccache-4.10-linux-x86_64.tar.xz
# tar -xf ccache-4.10-linux-x86_64.tar.xz
# cd ccache-4.10-linux-x86_64

# #sudo make install
# #ccache --version

# sudo cp ccache /usr/bin/
# sudo ln -sf ccache /usr/bin/gcc
# sudo ln -sf ccache /usr/bin/g++
# cd ..
# rm -rf ccache-4.10-linux*
# ccache --version

# export USE_CCACHE=1
# sleep 1
# export CCACHE_DIR=$PWD/cc
# sleep 1 
# ccache -s
# ccache -F 0
# ccache -M 0
# echo $CCACHE_DIR
# ccache -s

rm -rf .repo/local_manifests/
rm -rf device/xioami
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi

# Clone DerpFest
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14 --depth=1

# Clone local_manifests repository
git clone https://github.com/moewob/local_manifests --depth 1 -b derp .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/moewob/local_manifests.git
 fi

# repo sync
/opt/crave/resync.sh

# Set up build environment
cd frameworks/base && curl https://gist.githubusercontent.com/bagaskara815/b2abdff48cae8370ca2a0b867d7769e4/raw/fw.patch >> fw.patch && git am fw.patch && rm fw.patch && cd ../../
wget https://afdulfauzan.my.id/assets/keys.zip && unzip -o keys.zip -d vendor/derp/signing/ && rm keys.zip
source build/envsetup.sh

# brunch configuration
lunch derp_garnet-user

# Clean
make installclean

# Run
mka derp
