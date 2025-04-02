#!/bin/bash
# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# Add packages
#添加科学上网源
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall-packages
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall
git clone -b 18.06 --single-branch --depth 1 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone -b 18.06 --single-branch --depth 1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone --depth=1 https://github.com/ophub/luci-app-amlogic package/amlogic
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go package/ddnsgo
#git clone --depth=1 https://github.com/sirpdboy/NetSpeedTest package/NetSpeedTest
git clone --depth=1 --single-branch --branch "master" https://github.com/vernesong/OpenClash.git package/luci-app-openclash


git clone -b v5-lua --single-branch --depth 1 https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone -b lua --single-branch --depth 1 https://github.com/sbwml/luci-app-alist package/alist
#添加自定义的软件包源
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages ddns-go
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-ddns-go
# Remove packages
#删除lean库中的插件，使用自定义源中的包。

##添加软件包
git clone https://github.com/lhbox1/luci-app-adguardhome1 package/luci-app-adguardhome


#删除冲突插件
rm -rf $(find ./feeds/packages/net/ -type d -regex ".*\(dns2socks\|geoview\|ipt2socks\|microsocks\|naiveproxy\|shadowsocks-rust\|shadowsocksr-libev\|simple-obfs\|tcping\|tuic-client\|v2ray-plugin\|xray-plugin\).*")

rm -rf $(find ./feeds/luci/ -type d -regex ".*\(passwall\|openclash\|alist\|easymesh\|adguardhome\|lucky\|wechatpush\|ddns-go\|ssr-plus\).*")
#passwall
rm -rf feeds/packages/net/sing-box
rm -rf feeds/packages/net/trojan-plus
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/hysteria
##
rm -rf feeds/packages/net/adguardhome
rm -rf package/istore
rm -rf feeds/packages/net/lucky
rm -rf feeds/packages/net/alist




rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/luci/applications/luci-app-mosdns
#rm -rf feeds/luci/themes/luci-theme-design
#rm -rf feeds/luci/applications/luci-app-design-config

# Default IP
sed -i 's/192.168.1.1/192.168.15.99/g' package/base-files/files/bin/config_generate
#修改默认主机名
sed -i "s/hostname='.*'/hostname='N1'/g" ./package/base-files/files/bin/config_generate
#修改默认时间格式
sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S %A")/g' $(find ./package/*/autocore/files/ -type f -name "index.htm")
