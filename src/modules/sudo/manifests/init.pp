class sudo {
	include sudo::package

	file {
		"/etc/sudoers":
			ensure  => present,
			owner   => root,
			group   => root,
			mode    => 0440,
			source  => "puppet:///modules/sudo/sudoers",
			require => Class["sudo::package"],
		;
		"/etc/sudoers.site.d":
			ensure  => directory,
			recurse => true,
			purge   => true,
			force   => true,
			mode    => 0444, # Puppet will make directories executable
			owner   => root,
			group   => root,
			source  => "puppet:///modules/sudo/sudoers.site.d",
			require => Class["sudo::package"],
		;
	}
}
