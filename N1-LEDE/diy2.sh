#!/bin/bash
#=================================================

#下载使用master版本passwall
#wget -qO- https://github.com/xiaorouji/openwrt-passwall/archive/main.zip > temp1.zip
wget -qO- https://codeload.github.com/xiaorouji/openwrt-passwall/zip/refs/tags/25.3.9-1 > temp1.zip
unzip -q temp1.zip
rm -rf feeds/luci/applications/luci-app-passwall
#cp -r openwrt-passwall-main/luci-app-passwall package/

cp -r openwrt-passwall-25.3.9-1/luci-app-passwall package/
rm -rf temp1.zip
#rm -rf openwrt-passwall-main
rm -rf openwrt-passwall-25.3.9-1


#下载使用lucky
wget  -qO- https://codeload.github.com/gdy666/luci-app-lucky/zip/refs/tags/v2.15.8 > lucky.zip
unzip -q lucky.zip
cp -r luci-app-lucky-2.15.8/luci-app-lucky package/
cp -r luci-app-lucky-2.15.8/lucky package/
rm -rf lucky.zip
rm -rf luci-app-lucky-2.15.8
