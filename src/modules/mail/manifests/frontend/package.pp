class mail::frontend::package {
	include mail::dovecot

	package {
		["dovecot-imapd", "dovecot-managesieved"]:
			ensure  => latest,
			require => Class["mail::dovecot"],
			notify  => Class["mail::dovecot"],
		;
	}
}
