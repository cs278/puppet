class mail::opendkim::service {
	include mail::opendkim::package

	service {
		"opendkim":
			ensure     => running,
			enable     => true,
			hasstatus  => false,
			hasrestart => true,
			require    => Class["mail::opendkim::package"],
			subscribe  => Class["mail::opendkim::package"],
		;
	}
}
