class mail::storage::commissioned {
	include mail::storage::package

	$vmail_store = extlookup("mail::storage::store")

	# TODO: Specify user/groupname and create it
	$vmail_uid = extlookup("mail::storage::uid")
	$vmail_gid = extlookup("mail::storage::gid")
	$vmail_user = getuserbyuid($vmail_uid)
	$vmail_group = getuserbyuid($vmail_gid)

	$db_hosts = extlookup("mail::storage::hosts")
	$db_username = extlookup("mail::storage::username")
	$db_password = extlookup("mail::storage::password")
	$db_database = extlookup("mail::storage::database")

	$postmaster = extlookup("mail::postmaster")

	$etc_dovecot = "/etc/dovecot"

	file {
		"${etc_dovecot}":
			ensure  => directory,
			mode    => 0644,
			recurse => true,
			purge   => true,
			force   => true,
			owner   => root,
			group   => root,
			source  => "puppet:///mail/storage/dovecot",
			require => Class["mail::storage::package"],
		;
		"${etc_dovecot}/dovecot.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/dovecot.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/dovecot-sql.conf":
			ensure  => file,
			mode    => 0400,
			owner   => root,
			group   => root,
			content => template("mail/storage/dovecot-sql.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/conf.d/10-auth.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/conf.d/10-auth.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/conf.d/10-logging.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/conf.d/10-logging.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/conf.d/10-mail.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/conf.d/10-mail.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/conf.d/10-master.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/conf.d/10-master.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/conf.d/10-ssl.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/conf.d/10-ssl.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/conf.d/15-lda.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/conf.d/15-lda.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
		"${etc_dovecot}/auth.d/auth-sql.conf":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/storage/auth.d/auth-sql.conf.erb"),
			require => File[$etc_dovecot],
			notify  => Class["mail::storage::service"],
		;
	}
}
