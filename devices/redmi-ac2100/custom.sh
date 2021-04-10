# rm -Rf package/feeds/packages/node
# svn co https://github.com/coolsnowwolf/packages/trunk/lang/node package/feeds/custom/node

echo '
UnblockNeteaseMusic
' >> ipk

sed -i '/sub-web/d' ipk
