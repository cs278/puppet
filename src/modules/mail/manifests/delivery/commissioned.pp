class mail::delivery::commissioned {
	include mail::delivery::package

	$vmail_store = "/var/spool/mail"
	$vmail_uid = 8
	$vmail_gid = 8

	$db_hosts = "127.0.0.1"
	$db_username = "postfix"
	$db_password = "wibbleSpoonz"
	$db_database = "system_email"

	user {
		"mail":
			ensure  => present,
			uid     => $vmail_uid,
			gid     => $vmail_gid,
			home    => "/var/mail",
			shell   => "/bin/false",
			require => Group["mail"],
		;
	}

	group {
		"mail":
			ensure => present,
			gid    => $vmail_gid,
		;
	}

	mail::instance {
		"delivery":
			master  => template("mail/delivery/master.cf.erb"),
			main    => template("mail/delivery/main.cf.erb"),
			require => [File["${vmail_store}"], Class["mail::delivery::package"]],
		;
	}

	file {
		"${vmail_store}":
			ensure  => directory,
			mode    => 0755,
			owner   => mail,
			group   => mail,
			require => [Class["mail::delivery::package"], User["mail"]],
		;
		"/etc/postfix-delivery/mysql":
			ensure  => directory,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => Mail::Instance["delivery"],
		;
		"/etc/postfix-delivery/mysql/aliases.cf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => File["/etc/postfix-delivery/mysql"],
			notify  => Class["mail::service"],
			content => template("mail/delivery/mysql/aliases.cf.erb"),
		;
		"/etc/postfix-delivery/mysql/domains.cf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => File["/etc/postfix-delivery/mysql"],
			notify  => Class["mail::service"],
			content => template("mail/delivery/mysql/domains.cf.erb"),
		;
		"/etc/postfix-delivery/mysql/mailboxes.cf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => File["/etc/postfix-delivery/mysql"],
			notify  => Class["mail::service"],
			content => template("mail/delivery/mysql/mailboxes.cf.erb"),
		;
		"/etc/postfix-delivery/mysql/transport.cf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			require => File["/etc/postfix-delivery/mysql"],
			notify  => Class["mail::service"],
			content => template("mail/delivery/mysql/transport.cf.erb"),
		;
	}
}
