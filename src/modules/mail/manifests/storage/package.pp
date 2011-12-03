class mail::storage::package {
	package {
		["dovecot-common", "dovecot-sieve", "dovecot-mysql"]:
			ensure => latest,
		;
	}

	service {
		"dovecot":
			ensure  => running,
			require => Package["dovecot-common"],
		;
	}
}
