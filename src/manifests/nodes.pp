include common
include apt
include base

Exec {
	path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

node 'kinslayer.flat.cs278.org' {
	include sudo
	include git
}
