#!/bin/bash

shopt -s extglob

for ipk in $(ls package/feeds/custom | grep "luci-"); do		
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config	
done

echo '
CONFIG_PACKAGE_sub-web=m
CONFIG_PACKAGE_ddns-scripts-aliyun=m
CONFIG_PACKAGE_ddns-scripts-dnspod=m
CONFIG_PACKAGE_aria2=m
CONFIG_PACKAGE_default-settings=m
CONFIG_PACKAGE_tinyportmapper=m
CONFIG_PACKAGE_simple-torrent=m
CONFIG_PACKAGE_https-dns-proxy=m
CONFIG_PACKAGE_mwan3=m
CONFIG_PACKAGE_cdnspeedtest=m
CONFIG_PACKAGE_qBittorrent=m
CONFIG_PACKAGE_bpytop=m
' >> ./target/linux/x86/64/config-5.4

# sed -i 's/default m/default n/' Config-build.in

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

sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*

sed -i '/WARNING: Makefile/d' scripts/package-metadata.pl
sed -i '/warning: /d' scripts/config/menu.c
