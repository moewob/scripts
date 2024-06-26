rm -rf .repo/local_manifests/
rm -rf device/xioami
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi

# Clone DerpFest
repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14 --depth=1 --git-lfs

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
