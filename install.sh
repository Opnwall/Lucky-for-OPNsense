#!/bin/sh
set -u

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run this installer as root."
	exit 1
fi

cp -R -f src/etc/* /etc/
cp -R -f src/usr/* /usr/
chmod 0644 /etc/rc.conf.d/lucky 2>/dev/null || true
chmod 0755 /usr/local/etc/rc.d/os-lucky /usr/local/bin/lucky 2>/dev/null || true
rm -f /var/lib/php/tmp/opnsense_menu_cache.xml /var/lib/php/tmp/opnsense_acl_cache.json
service configd restart >/dev/null 2>&1 || true
configctl -f service reload all >/dev/null 2>&1 || true
configctl webgui restart >/dev/null 2>&1 || service lighttpd onerestart >/dev/null 2>&1 || true
service os-lucky onerestart >/dev/null 2>&1 || service os-lucky onestart >/dev/null 2>&1 || true
service os-lucky onestatus
