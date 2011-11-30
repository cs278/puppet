class mail::gateway::commissioned {
	include mail::gateway::package

	$index = extlookup("mail::gateway::index")

	mail::instance {
		"gateway":
			master  => template("mail/gateway/master.cf.erb"),
			main    => template("mail/gateway/main.cf.erb"),
			require => Class["mail::gateway::package"],
		;
	}

	file {
		"/etc/postfix-policyd-spf-python":
			ensure  => directory,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => [Mail::Instance["gateway"], Class["Mail::Gateway::Package"]],
		;
		"/etc/postfix-policyd-spf-python/policyd-spf.conf":
			ensure => file,
			mode   => 0444,
			owner  => root,
			group  => root,
			source => "puppet:///modules/mail/gateway/policyd-spf.conf",
			require => File["/etc/postfix-policyd-spf-python"],
		;
	}
}
