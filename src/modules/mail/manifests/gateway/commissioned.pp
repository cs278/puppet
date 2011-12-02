class mail::gateway::commissioned {
	include mail::gateway::package

	$index = extlookup("mail::gateway::index")

	$db_hosts = extlookup("mail::gateway::hosts")
	$db_username = extlookup("mail::gateway::username")
	$db_password = extlookup("mail::gateway::password")
	$db_database = extlookup("mail::gateway::database")

	$interfaces = extlookup("mail::delivery::interfaces", undef)

	$etc = "/etc/postfix-gateway"

	mail::instance {
		"gateway":
			master  => template("mail/gateway/master.cf.erb"),
			main    => template("mail/gateway/main.cf.erb"),
			require => Class["mail::gateway::package"],
		;
	}

	file {
		"${etc}/mysql":
			ensure  => directory,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => Mail::Instance["gateway"],
		;
		"${etc}/mysql/domains.cf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => File["${etc}/mysql"],
			notify  => Class["mail::service"],
			content => template("mail/gateway/mysql/domains.cf.erb"),
		;
		"${etc}/mysql/recipients.cf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => File["${etc}/mysql"],
			notify  => Class["mail::service"],
			content => template("mail/gateway/mysql/recipients.cf.erb"),
		;
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
