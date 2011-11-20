class puppet::package {
	include puppet::repository

	package {
		"puppet":
			ensure  => latest,
			require => Class["puppet::repository"],
		;
	}
}
