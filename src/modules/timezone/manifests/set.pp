define timezone::set() {
	include timezone::package

	$timezone = $title

	$zoneinfo = "/usr/share/zoneinfo/${timezone}"

	file {
		"/etc/timezone":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => $timezone,
			require => Class["timezone::package"],
		;
		"/etc/localtime":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => file($zoneinfo),
			require => Class["timezone::package"],
		;
	}
}
