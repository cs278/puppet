class mail::delivery::commissioned inherits mail::storage::commissioned {
	include mail::delivery::package

	$interfaces = extlookup("mail::delivery::interfaces", "")

	$instance = "delivery"

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

	@mail::instance {
		"delivery":
			master  => template("mail/delivery/master.cf.erb"),
			main    => template("mail/delivery/main.cf.erb"),
			require => [File["${vmail_store}"], Class["mail::delivery::package"]],
		;
	}

	@mail::instance::file {
		"${vmail_store}":
			instance => $instance,
			ensure  => directory,
			mode    => 0755,
			owner   => mail,
			group   => mail,
			require => [Class["mail::delivery::package"], User["mail"]],
		;
	}

	@mail::instance::config::file {
		"mysql":
			instance => $instance,
			ensure  => directory,
			mode    => 0444,
			owner   => root,
			group   => root,
		;
		"mysql/aliases.cf":
			instance => $instance,
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/delivery/mysql/aliases.cf.erb"),
		;
		"mysql/domains.cf":
			instance => $instance,
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/delivery/mysql/domains.cf.erb"),
		;
		"mysql/mailboxes.cf":
			instance => $instance,
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/delivery/mysql/mailboxes.cf.erb"),
		;
		"mysql/transport.cf":
			instance => $instance,
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/delivery/mysql/transport.cf.erb"),
		;
	}

	if $vmail_store != "/var/spool/mail" {
		@mail::instance::file {
			"/var/spool/mail":
				instance => $instance,
				ensure  => symlink,
				target  => $vmail_store,
				replace => true,
				force   => true,
			;
		}
	}
}
