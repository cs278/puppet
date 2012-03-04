class base::gnupg {
	include gpg::package

	$homedir = "/etc/system-key"

	file {
		"${homedir}":
			ensure  => directory,
			owner   => root,
			group   => adm,
			mode    => 0750,
			require => Class["gpg::package"],
		;
		"/usr/local/sbin/update-system-key":
			ensure  => file,
			owner   => root,
			group   => 0,
			mode    => 0555,
			source  => "puppet:///modules/base/gnupg/generate",
			require => File[$homedir],
		;
	}

	exec {
		"/usr/local/sbin/update-system-key ${homedir}":
			require => File["/usr/local/sbin/update-system-key"],
		;
	}
}
