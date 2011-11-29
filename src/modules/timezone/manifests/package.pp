class timezone::package {
	package {
		"tzdata":
			ensure => latest,
		;
	}
}
