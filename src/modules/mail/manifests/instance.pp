define mail::instance($master, $main, $require = undef) {

	file {
		"/etc/postfix-$name":
			ensure  => directory,
			owner   => root,
			group   => root,
			mode    => 0555,
			require => $require,
		;
		"/var/spool/postfix-$name":
			ensure  => directory,
			owner   => root,
			group   => root,
			mode    => 0755,
			require => $require,
		;
		"/var/lib/postfix-$name":
			ensure  => directory,
			owner   => postfix,
			group   => postfix,
			mode    => 0755,
			require => $require,
		;
		"/etc/postfix-${name}/dynamicmaps.cf":
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => 0444,
			content => file("/etc/postfix/dynamicmaps.cf"),
			require => File["/etc/postfix-${name}"],
		;
		"/etc/postfix-${name}/master.cf":
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => 0444,
			content => $master,
			require => File["/etc/postfix-${name}"],
		;
		"/etc/postfix-${name}/main.cf":
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => 0444,
			content => $main,
			require => File["/etc/postfix-${name}"],
		;
	}
}
