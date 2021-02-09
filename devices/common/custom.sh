#!/bin/bash

shopt -s extglob

for ipk in $(ls package/feeds/custom | grep "luci-app"); do	
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config
done

rm -Rf feeds/luci/!(luci.mk|build|modules)
rm -Rf feeds/luci/modules/!(luci-base)

rm -Rf feeds/packages/{sound,net,multimedia,mail,admin,ipv6,utils,devel,lang/php*,lang/ruby}
rm -Rf package/{network,system,utils,firmware,kernel,devel}

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*


