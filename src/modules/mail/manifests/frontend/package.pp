class mail::frontend::package inherits mail::storage::package {
	package {
		["dovecot-imapd", "dovecot-managesieved"]:
			ensure  => latest,
			require => Class["mail::storage::package"],
			notify  => Class["mail::storage::service"],
		;
	}
}
