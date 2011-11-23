class mail::service {
	include mail::package

	service {
		'postfix':
			ensure     => running,
			enable     => true,
			hasstatus  => true,
			hasrestart => true,
			require    => Class["mail::package"],
			subscribe  => Class["mail::package"],
		;
	}
}
