class timezone {
	include timezone::package
	include timezone::set

	$timezone = extlookup("timezone", "Etc/UTC")

	timezone::set {
		"${timezone}":;
	}
}
