#!/bin/bash

shopt -s extglob

sed -i '/	refresh_config();/d' scripts/feeds

rm -rf feeds/custom/{frp,xray-core,.github,diy,mt-drivers,mt7601u-ap,mtk-eip93,r81*,rtl8*,shortcut-fe,luci-app-{turboacc,mtwifi},.gitignore,LICENSE,README.md}

svn co https://github.com/immortalwrt/packages/trunk/lang/golang feeds/packages/lang/golang

./scripts/feeds update -a
./scripts/feeds install -a

sed -i 's/Os/O2/g' include/target.mk
rm -rf ./feeds/packages/lang/golang
svn co https://github.com/immortalwrt/packages/trunk/lang/golang feeds/packages/lang/golang
sed -i "s/+nginx\( \|$\)/+nginx-ssl\1/g"  package/feeds/custom/*/Makefile
sed -i 's/+python\( \|$\)/+python3/g' package/feeds/custom/*/Makefile
sed -i 's?../../lang?$(TOPDIR)/feeds/packages/lang?g' package/feeds/custom/*/Makefile
for ipk in $(find package/feeds/custom/* -maxdepth 0); do	
	if [[ ! -d "$ipk/patches" && ! "$(grep "codeload.github.com" $ipk/Makefile)" ]]; then
		find $ipk/ -maxdepth 1 -name "Makefile" ! -path *tcping* ! -path *n2n_v2* \
		| xargs -i sed -i "s/PKG_SOURCE_VERSION:=[0-9a-z]\{15,\}/PKG_SOURCE_VERSION:=HEAD/g" {}
	fi
done
sed -i 's/$(VERSION) &&/$(VERSION) ;/g' include/download.mk

mv feeds/base feeds/base.bak
mv feeds/packages feeds/packages.bak
make defconfig
rm -Rf tmp
mv feeds/base.bak feeds/base
mv feeds/packages.bak feeds/packages
sed -i 's/CONFIG_ALL=y/CONFIG_ALL=n/' .config

cp -f devices/common/po2lmo staging_dir/host/bin/po2lmo
chmod +x staging_dir/host/bin/po2lmo

sed -i 's,$(STAGING_DIR_HOST)/bin/upx,upx,' package/feeds/custom/*/Makefile

sed -i "/mediaurlbase/d" package/feeds/*/luci-theme*/root/etc/uci-defaults/*

sed -i '/WARNING: Makefile/d' scripts/package-metadata.pl

