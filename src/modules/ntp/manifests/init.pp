class ntp {
	include ntp::package
	include ntp::service

	$pool = extlookup("ntp::pool", "")

	file {
		"/etc/ntp.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("ntp/ntp.conf.erb"),
			require => Class["ntp::package"],
			notify  => Class["ntp::service"],
		;
	}
}
