class mail::gateway::decommissioned {
	include mail::gateway::package
	include mail::opendkim::verifying

	$instance = "gateway"

	group {
		"policyd-spf":
			ensure => absent,
		;
	}

	user {
		"policyd-spf":
			ensure   => absent,
		;
	}

	@mail::instance {
		"${instance}":
			master  => "",
			main    => "",
			require => [
				Class["mail::gateway::package"],
				Class["mail::opendkim::verifying"],
				User["policyd-spf"],
			],
		;
	}

	@mail::instance::config::file {
		"${instance}/mysql":
			instance => $instance,
			path     => "mysql",
			ensure   => absent,
		;
		"${instance}/mysql/domains.cf":
			instance => $instance,
			path     => "mysql/domains.cf",
			ensure   => absent,
		;
		"${instance}/mysql/recipients.cf":
			instance => $instance,
			path     => "mysql/recipients.cf",
			ensure   => absent,
		;
	}

	@mail::instance::file {
		"/etc/postfix-policyd-spf-python":
			instance => $instance,
			ensure   => absent,
			require  => [Mail::Instance["${instance}"], Class["Mail::Gateway::Package"]],
		;
		"/etc/postfix-policyd-spf-python/policyd-spf.conf":
			instance => $instance,
			ensure   => absent,
			require  => File["/etc/postfix-policyd-spf-python"],
		;
	}
}
