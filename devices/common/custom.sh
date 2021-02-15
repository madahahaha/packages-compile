#!/bin/bash

shopt -s extglob

for ipk in $(ls package/feeds/custom | grep "luci-"); do		
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config	
done

sed -i 's/default m/default n/' Config-build.in

rm -Rf feeds/{routing,telephony,freifunk}

rm -Rf feeds/luci/{applications,collections,protocols,themes,libs}
rm -Rf feeds/luci/modules/!(luci-base)

rm -Rf feeds/packages/!(lang|libs|devel|utils|net)
rm -Rf feeds/packages/utils/!(pcsc-lite|xz)
rm -Rf feeds/packages/net/!(mosquitto|curl)
rm -Rf feeds/packages/lang/!(python|golang)
rm -Rf feeds/base/package/kernel/!(cryptodev-linux|linux)
rm -Rf feeds/base/package/network/!(services)
rm -Rf feeds/base/package/network/services/!(ppp)
rm -Rf feeds/base/package/utils/!(util-linux|lua)
rm -Rf feeds/base/package/system/!(opkg|uci)

sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*

