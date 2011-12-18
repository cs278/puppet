class network::interfaces::setup {
	file {
		"/etc/network/interfaces.d":
			ensure  => directory,
			mode    => 0555,
			owner   => root,
			group   => root,
			recurse => true,
			purge   => true,
			force   => true,
			source  => "puppet:///modules/network/interfaces.d",
		;
		"/etc/network/interfaces":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
		;
		"/usr/local/sbin/update-interfaces":
			ensure  => file,
			mode    => 0555,
			owner   => root,
			group   => root,
			source  => "puppet:///modules/network/update-interfaces",
		;
	}
}
