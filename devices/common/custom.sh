for ipk in $(ls package/feeds/custom | grep "luci-app"); do	
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config
done

rm -Rf feeds/luci
rm -Rf feeds/packages/{sound,net,multimedia,mail,admin,ipv6,utils,lang}

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*

mv -f feeds/packages/net/nlbwmon package/feeds/custom/nlbwmon

