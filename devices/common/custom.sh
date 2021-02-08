for ipk in $(ls package/feeds/custom | grep "luci-app"); do	
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config
done

rm -Rf feeds/luci/applications feeds/luci/modules
rm -Rf feeds/packages/{sound,net,multimedia,mail,admin,ipv6,utils}

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*

sed -i '/+docker/d' package/feeds/custom/luci-app-dockerman/Makefile

mv -f feeds/packages/net/nlbwmon package/feeds/custom/nlbwmon

rm -Rf package/feeds/packages/ffmpeg
