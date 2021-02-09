#!/bin/bash

shopt -s extglob

for ipk in $(ls package/feeds/custom | grep "luci-app"); do	
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config
done

rm -Rf feeds/{routing,telephony,freifunk}

# rm -Rf feeds/luci/!(luci.mk|build|modules)
# rm -Rf feeds/luci/modules/!(luci-base)

rm -Rf feeds/packages/!(lang)
rm -Rf feeds/packages/lang/*/!(*.mk)
rm -Rf package/!(base-files|feeds|Makefile)

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*


