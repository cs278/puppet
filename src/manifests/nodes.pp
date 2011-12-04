# extlookup() configuration
$extlookup_datadir = "conf"
$extlookup_precedence = ["private/${::fqdn}", "private/common", "${::fqdn}", "common"]

include common
include apt
include base
include timezone
include ntp

Exec {
	path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

node default {
	include sudo
	include git
	include roles
}
