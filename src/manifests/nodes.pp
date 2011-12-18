# extlookup() configuration
$extlookup_datadir = "conf"
$extlookup_precedence = [
	"private/${::fqdn}",
	"private/location/${::location}",
	"private/country/${::country}",
	"private/region/${::region}",
	"private/common",
	"${::fqdn}",
	"location/${::location}",
	"country/${::country}",
	"region/${::region}",
	"common",
]

include common
include apt
include base
include network
include timezone
include ntp

Exec {
	path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

node default {
	notice("Location: ${::location}")
	notice("Country: ${::country}")
	notice("Region: ${::region}")
	notice("Linode? ${::linode}")
	notice("Linode ID: ${::linode_id}")

	include sudo
	include git
	include roles
}
