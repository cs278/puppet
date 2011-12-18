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

	file {
		"${config}":
			ensure  => $ensure ? {
				"absent" => absent,
				default  => directory,
			},
			recurse => $ensure ? {
				"absent" => true,
				default  => false,
			},
			owner   => root,
			group   => root,
			mode    => 0555,
		;
		"${queue}":
			ensure  => $ensure ? {
				"absent" => absent,
				default  => directory,
			},
			recurse => $ensure ? {
				"absent" => true,
				default  => false,
			},
			owner   => root,
			group   => root,
			mode    => 0755,
		;
		"${data}":
			ensure  => $ensure ? {
				"absent" => absent,
				default  => directory,
			},
			recurse => $ensure ? {
				"absent" => true,
				default  => false,
			},
			owner   => postfix,
			group   => postfix,
			mode    => 0755,
		;
		"${config}/dynamicmaps.cf":
			ensure  => $ensure ? {
				"absent" => absent,
				default  => link,
			},
			owner   => root,
			group   => root,
			target  => "/etc/postfix/dynamicmaps.cf",
			require => [Class["mail::package"], File["/etc/postfix-${name}"]],
			notify  => Class["mail::service"],
		;
		"${config}/master.cf":
			ensure  => $ensure ? {
				"absent" => absent,
				default  => file,
			},
			owner   => root,
			group   => root,
			mode    => 0444,
			content => $master,
			require => File["/etc/postfix-${name}"],
			notify  => Class["mail::service"],
		;
		"${config}/main.cf":
			ensure  => $ensure ? {
				"absent" => absent,
				default  => file,
			},
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
}
