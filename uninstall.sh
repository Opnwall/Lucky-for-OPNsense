#!/bin/sh
set -u

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run this uninstaller as root."
	exit 1
fi

service os-lucky onestop >/dev/null 2>&1 || true
rm -f \
	/etc/rc.conf.d/lucky \
	/usr/local/bin/lucky \
	/usr/local/etc/rc.d/os-lucky \
	/usr/local/www/lucky.php \
	/usr/local/opnsense/service/conf/actions.d/actions_lucky.conf \
	/usr/local/opnsense/mvc/app/models/OPNsense/Lucky/Menu/Menu.xml \
	/usr/local/opnsense/mvc/app/models/OPNsense/Lucky/ACL/ACL.xml \
	/var/log/lucky.log
rmdir \
	/usr/local/opnsense/mvc/app/models/OPNsense/Lucky/Menu \
	/usr/local/opnsense/mvc/app/models/OPNsense/Lucky/ACL \
	/usr/local/opnsense/mvc/app/models/OPNsense/Lucky 2>/dev/null || true
rm -f /var/lib/php/tmp/opnsense_menu_cache.xml /var/lib/php/tmp/opnsense_acl_cache.json
service configd restart >/dev/null 2>&1 || true
configctl -f service reload all >/dev/null 2>&1 || true
configctl webgui restart >/dev/null 2>&1 || service lighttpd onerestart >/dev/null 2>&1 || true
echo "Lucky for OPNsense has been uninstalled."
