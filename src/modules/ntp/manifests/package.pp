class ntp::package {
	package {
		"ntp":
			ensure => present,
		;
	}
}
