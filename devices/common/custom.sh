sed -i '/+docker-ce /d' package/feeds/custom/luci-app-dockerman/Makefile
sed -i 's/+libcap /+libcap +libcap-bin /' package/feeds/custom/luci-app-openclash/Makefile
