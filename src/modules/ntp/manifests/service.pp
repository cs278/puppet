class ntp::service {
	include ntp::package

	service {
		"ntp":
			ensure    => running,
			require   => Class["ntp::package"],
			subscribe => Class["ntp::package"],
		;
	}
}
