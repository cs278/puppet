define mail::instance($ensure = present, $master, $main) {

	if ($group == "") {
		$group = $name
	}
	$ident = "postfix-$name"
	$config = "/etc/${ident}"
	$queue = "/var/spool/${ident}"
	$data = "/var/lib/${ident}"
	$domain = "cs278.org"
	$postmaster = extlookup("mail::postmaster")

	if $ensure != "absent" {
		file {
			"${config}":
				ensure  => directory,
				owner   => root,
				group   => root,
				mode    => 0555,
			;
			"${queue}":
				ensure  => directory,
				owner   => root,
				group   => root,
				mode    => 0755,
			;
			"${data}":
				ensure  => directory,
				owner   => postfix,
				group   => postfix,
				mode    => 0755,
			;
			"${config}/dynamicmaps.cf":
				ensure  => link,
				owner   => root,
				group   => root,
				target  => "/etc/postfix/dynamicmaps.cf",
				require => [Class["mail::package"], File["/etc/postfix-${name}"]],
				notify  => Class["mail::service"],
			;
			"${config}/master.cf":
				ensure  => file,
				owner   => root,
				group   => root,
				mode    => 0444,
				content => $master,
				require => File["/etc/postfix-${name}"],
				notify  => Class["mail::service"],
			;
			"${config}/main.cf":
				ensure  => file,
				owner   => root,
				group   => root,
				mode    => 0444,
				content => template("mail/main.instance.cf.erb"),
				require => File["/etc/postfix-${name}"],
				notify  => Class["mail::service"],
			;
		}

		Mail::Instance::Config::File <| instance == $name |>
		Mail::Instance::File <| instance == $name |>
	} else {
		Mail::Instance::Config::File <| instance == $name |>
		Mail::Instance::File <| instance == $name |>

		file {
			"${config}":
				ensure  => absent,
				recurse => true,
			;
			"${queue}":
				ensure  => absent,
				recurse => true,
			;
			"${data}":
				ensure  => absent,
				recurse => true,
			;
			"${config}/dynamicmaps.cf":
				ensure  => absent,
				require => [Class["mail::package"], File["/etc/postfix-${name}"]],
				notify  => Class["mail::service"],
			;
			"${config}/master.cf":
				ensure  => absent,
				require => File["/etc/postfix-${name}"],
				notify  => Class["mail::service"],
			;
			"${config}/main.cf":
				ensure  => absent,
				require => File["/etc/postfix-${name}"],
				notify  => Class["mail::service"],
			;
		}
	}
}
