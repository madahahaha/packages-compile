#!/bin/bash

shopt -s extglob

rm -rf package/feeds/custom/{luci-app-turboacc,luci-app-mtwifi}

for ipk in $(ls package/feeds/custom | grep "luci-"); do		
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config	
    echo "$ipk" >> ipk
done

echo '
sub-web
ddns-scripts-aliyun
ddns-scripts-dnspod
aria2
default-settings
tinyportmapper
simple-torrent
https-dns-proxy
mwan3
cdnspeedtest
qBittorrent
bpytop
' >> ipk

rm -Rf feeds/luci/{applications,collections,protocols,themes,libs}
rm -Rf feeds/luci/modules/!(luci-base)

rm -Rf feeds/packages/!(lang|libs|devel|utils|net)
rm -Rf feeds/packages/utils/!(pcsc-lite|xz)
rm -Rf feeds/packages/net/!(mosquitto|curl)
rm -Rf feeds/packages/lang/!(golang|python)
rm -Rf feeds/base/package/kernel/!(cryptodev-linux|linux)
rm -Rf feeds/base/package/network/!(services)
rm -Rf feeds/base/package/network/services/!(ppp)
rm -Rf feeds/base/package/utils/!(util-linux|lua)
rm -Rf feeds/base/package/system/!(opkg|uci)

mv feeds/base base.bak
mv feeds/packages packages.bak
make defconfig
rm -Rf tmp
mv feeds/base.bak base
mv feeds/packages.bak packages
sed -i 's/CONFIG_ALL=y/CONFIG_ALL=n/' .config

sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*

sed -i '/WARNING: Makefile/d' scripts/package-metadata.pl

