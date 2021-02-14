#!/bin/bash

shopt -s extglob

for ipk in $(ls package/feeds/custom | grep "luci-"); do	
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config
done

rm -Rf feeds/{routing,telephony,freifunk}

rm -Rf feeds/luci/{applications,collections,protocols,themes}
rm -Rf feeds/luci/modules/!(luci-base)

rm -Rf feeds/packages/!(lang|libs|devel|utils)
rm -Rf feeds/packages/utils/!(pcsc-lite)
rm -Rf feeds/packages/lang/!(|python|golang)
rm -Rf feeds/base/package/kernel
rm -Rf feeds/base/package/network/!(ppp)
rm -Rf feeds/base/package/system/{rpcd,procd}

rm -Rf feeds/base/package/utils/spidev_test

sed -i 's,$(STAGING_DIR_HOST)/bin/,,' package/feeds/custom/*/Makefile

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*


