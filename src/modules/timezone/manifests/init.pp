class timezone {
	include timezone::package

	$timezone = extlookup("timezone", "Etc/UTC")

	timezone::set {
		"${timezone}":
			require => Class["timezone::package"],
		;
	}
}
