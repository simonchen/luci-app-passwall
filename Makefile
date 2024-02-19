# Copyright (C) 2018-2020 L-WRT Team
# Copyright (C) 2021-2023 xiaorouji
#
# This is free software, licensed under the GNU General Public License v3.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-passwall
PKG_VERSION:=4.73-3
PKG_RELEASE:=

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI support for PassWall
	PKGARCH:=all
	DEPENDS:=+coreutils +coreutils-base64 +coreutils-nohup +curl \
		+chinadns-ng +dns2socks +dns2tcp +ip-full +libuci-lua +lua +luci-compat +luci-lib-jsonc \
		+microsocks +resolveip +tcping +unzip
endef

PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_$(PKG_NAME)_Iptables_Transparent_Proxy \
	CONFIG_PACKAGE_$(PKG_NAME)_Nftables_Transparent_Proxy \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Brook \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Haproxy \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Hysteria \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_NaiveProxy \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Simple_Obfs \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_SingBox \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Trojan_GO \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Trojan_Plus \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_tuic_client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_V2ray_Geodata \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_V2ray_Plugin \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Xray \

#LUCI_TITLE:=LuCI support for PassWall
#LUCI_PKGARCH:=all
#LUCI_DEPENDS:=+coreutils +coreutils-base64 +coreutils-nohup +curl \
	+chinadns-ng +dns2socks +dns2tcp +ip-full +libuci-lua +lua +luci-compat +luci-lib-jsonc \
	+microsocks +resolveip +tcping +unzip

define Package/$(PKG_NAME)/config
menu "Configuration"

config PACKAGE_$(PKG_NAME)_Iptables_Transparent_Proxy
	bool "Iptables Transparent Proxy"
	select PACKAGE_dnsmasq-full
	select PACKAGE_ipset
	select PACKAGE_ipt2socks
	select PACKAGE_iptables
	select PACKAGE_iptables-zz-legacy
	select PACKAGE_iptables-mod-conntrack-extra
	select PACKAGE_iptables-mod-iprange
	select PACKAGE_iptables-mod-socket
	select PACKAGE_iptables-mod-tproxy
	select PACKAGE_kmod-ipt-nat
	depends on PACKAGE_$(PKG_NAME)
	default y if ! PACKAGE_firewall4

config PACKAGE_$(PKG_NAME)_Nftables_Transparent_Proxy
	bool "Nftables Transparent Proxy"
	select PACKAGE_dnsmasq-full
	select PACKAGE_ipt2socks
	select PACKAGE_nftables
	select PACKAGE_kmod-nft-socket
	select PACKAGE_kmod-nft-tproxy
	select PACKAGE_kmod-nft-nat
	depends on PACKAGE_$(PKG_NAME)
	default y if PACKAGE_firewall4

config PACKAGE_$(PKG_NAME)_INCLUDE_Brook
	bool "Include Brook"
	select PACKAGE_brook
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Haproxy
	bool "Include Haproxy"
	select PACKAGE_haproxy
	default y if aarch64||arm||i386||x86_64

config PACKAGE_$(PKG_NAME)_INCLUDE_Hysteria
	bool "Include Hysteria"
	select PACKAGE_hysteria
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_NaiveProxy
	bool "Include NaiveProxy"
	depends on !(arc||(arm&&TARGET_gemini)||armeb||mips||mips64||powerpc)
	select PACKAGE_naiveproxy
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client
	bool "Include Shadowsocks Libev Client"
	select PACKAGE_shadowsocks-libev-ss-local
	select PACKAGE_shadowsocks-libev-ss-redir
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server
	bool "Include Shadowsocks Libev Server"
	select PACKAGE_shadowsocks-libev-ss-server
	default y if aarch64||arm||i386||x86_64

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Client
	bool "Include Shadowsocks Rust Client"
	depends on aarch64||arm||i386||mips||mipsel||x86_64
	select PACKAGE_shadowsocks-rust-sslocal
	default y if aarch64

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Server
	bool "Include Shadowsocks Rust Server"
	depends on aarch64||arm||i386||mips||mipsel||x86_64
	select PACKAGE_shadowsocks-rust-ssserver
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client
	bool "Include ShadowsocksR Libev Client"
	select PACKAGE_shadowsocksr-libev-ssr-local
	select PACKAGE_shadowsocksr-libev-ssr-redir
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server
	bool "Include ShadowsocksR Libev Server"
	select PACKAGE_shadowsocksr-libev-ssr-server
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Simple_Obfs
	bool "Include Simple-Obfs (Shadowsocks Plugin)"
	select PACKAGE_simple-obfs
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_SingBox
	bool "Include Sing-Box"
	select PACKAGE_sing-box
	default y if aarch64||arm||i386||x86_64

config PACKAGE_$(PKG_NAME)_INCLUDE_Trojan_GO
	bool "Include Trojan-GO"
	select PACKAGE_trojan-go
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_Trojan_Plus
	bool "Include Trojan-Plus"
	select PACKAGE_trojan-plus
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_tuic_client
	bool "Include tuic-client"
	depends on aarch64||arm||i386||x86_64
	select PACKAGE_tuic-client
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_V2ray_Geodata
	bool "Include V2ray_Geodata"
	select PACKAGE_v2ray-geoip
	select PACKAGE_v2ray-geosite
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_V2ray_Plugin
	bool "Include V2ray-Plugin (Shadowsocks Plugin)"
	select PACKAGE_v2ray-plugin
	default y if aarch64||arm||i386||x86_64

config PACKAGE_$(PKG_NAME)_INCLUDE_Xray
	bool "Include Xray"
	select PACKAGE_xray-core
	default y if aarch64||arm||i386||x86_64

config PACKAGE_$(PKG_NAME)_INCLUDE_Xray_Plugin
	bool "Include Xray-Plugin (Shadowsocks Plugin)"
	select PACKAGE_xray-plugin
	default n

endmenu
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/Prepare
	$(CP) $(CURDIR)/root $(PKG_BUILD_DIR)
	$(CP) $(CURDIR)/luasrc $(PKG_BUILD_DIR)
	$(foreach po,$(wildcard ${CURDIR}/po/zh-cn/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
	exit 0
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./root/etc/config/passwall_server $(1)/etc/config/passwall_server

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_CONF) ./root/etc/uci-defaults/* $(1)/etc/uci-defaults

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./root/etc/init.d/passwall $(1)/etc/init.d/passwall
	$(INSTALL_BIN) ./root/etc/init.d/passwall_server $(1)/etc/init.d/passwall_server

	$(INSTALL_DIR) $(1)/usr/share/passwall
	cp -pR ./root/usr/share/passwall/* $(1)/usr/share/passwall

	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	cp -pR ./root/usr/share/rpcd/acl.d/* $(1)/usr/share/rpcd/acl.d

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.*.lmo $(1)/usr/lib/lua/luci/i18n/
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/passwall
/etc/config/passwall_server
/usr/share/passwall/rules/direct_host
/usr/share/passwall/rules/direct_ip
/usr/share/passwall/rules/proxy_host
/usr/share/passwall/rules/proxy_ip
/usr/share/passwall/rules/block_host
/usr/share/passwall/rules/block_ip
/usr/share/passwall/rules/lanlist_ipv4
/usr/share/passwall/rules/lanlist_ipv6
/usr/share/passwall/rules/domains_excluded
endef

#include $(TOPDIR)/feeds/luci/luci.mk
#include ../luci.mk
$(eval $(call BuildPackage,$(PKG_NAME)))
# call BuildPackage - OpenWrt buildroot signature
