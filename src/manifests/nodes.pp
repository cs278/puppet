include common
include apt
include base

# extlookup() configuration
$extlookup_datadir = "conf"
$extlookup_precedence = ["private/${::fqdn}", "private/common", "${::fqdn}", "common"]

Exec {
	path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

node default {
	include sudo
	include git
}
