class mail::storage::service {
	include mail::storage::package

	service {
		"dovecot":
			ensure     => running,
			enable     => true,
			hasstatus  => true,
			# Restart seems unreliable
			hasrestart => false,
			require    => Class["mail::storage::package"],
			subscribe  => Class["mail::storage::package"],
		;
	}
}
