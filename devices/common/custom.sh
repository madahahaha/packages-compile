for ipk in $(ls package/feeds/custom | grep "luci-app"); do	
  	echo "CONFIG_PACKAGE_$ipk=m" >> .config
done

find package/feeds/custom -maxdepth 0 -name "luci-app"

sed -i "/mediaurlbase/d" package/*/*/luci-theme*/root/etc/uci-defaults/*

sed -i '/+docker/d' package/feeds/custom/luci-app-dockerman/Makefile

mv -f feeds/packages/net/nlbwmon package/feeds/custom/nlbwmon

rm -Rf package/feeds/packages/ffmpeg
