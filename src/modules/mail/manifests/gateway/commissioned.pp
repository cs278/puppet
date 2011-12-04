class mail::gateway::commissioned {
	include mail::gateway::package
	include mail::opendkim::verifying

	$index = extlookup("mail::gateway::index")
	$hub = extlookup("mail::gateway::hub")

	$db_hosts = extlookup("mail::gateway::hosts")
	$db_username = extlookup("mail::gateway::username")
	$db_password = extlookup("mail::gateway::password")
	$db_database = extlookup("mail::gateway::database")

	$interfaces = extlookup("mail::gateway::interfaces", "")

	$etc = "/etc/postfix-gateway"

	group {
		"policyd-spf":
			ensure => present,
			system => true,
		;
	}

	user {
		"policyd-spf":
			ensure   => present,
			gid      => "policyd-spf",
			home     => "/home/policyd-spf",
			shell    => "/bin/false",
			password => '*',
			system   => true,
		;
	}

	mail::instance {
		"gateway":
			master  => template("mail/gateway/master.cf.erb"),
			main    => template("mail/gateway/main.cf.erb"),
			require => [
				Class["mail::gateway::package"],
				Class["mail::opendkim::verifying"],
				User["policyd-spf"],
			],
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
