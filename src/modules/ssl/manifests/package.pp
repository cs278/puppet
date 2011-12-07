class ssl::package {
	package {
		"ca-certificates":
			ensure => latest,
		;
	}
}
