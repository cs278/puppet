class mail::delivery::package {
	include mail::mysql

	package {
		"dovecot-common":
			ensure => latest,
		;
	}
}
