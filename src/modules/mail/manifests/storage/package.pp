class mail::storage::package {
	package {
		["dovecot-common", "dovecot-sieve", "dovecot-mysql"]:
			ensure => latest,
		;
	}
}
