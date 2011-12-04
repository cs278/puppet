class mail::opendkim {
	include mail::opendkim::service

	file {
		"/etc/opendkim.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			notify  => Class["mail::opendkim::service"],
			require => Class["mail::opendkim::package"],
		;
	}
}
