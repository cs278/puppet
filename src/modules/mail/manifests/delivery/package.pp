class mail::delivery::package {
	include mail::package
	include mail::service

	package {
		"postfix-mysql":
			ensure  => installed,
			require => Class["mail::package"],
			notify  => Class["mail::service"],
		;
	}
}
