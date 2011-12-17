define ssh::server::user($username = $name, $allow, $config = "") {
	include ssh::server::allowdeny
	include ssh::server::service

	validate_string($username)
	validate_bool($allow)
	validate_string($config)

	$dir = $allow ? {
		true => "allow",
		false => "deny",
	}

	$path = "/etc/ssh/${dir}-users.d/${username}"

	file {
		"${path}":
			ensure  => file,
			mode    => 0550,
			owner   => root,
			group   => 0,
			content => $allow ? {
				true  => $config,
				false => "",
			},
			require => Class["ssh::server::allowdeny"],
			notify  => Class["ssh::server::service"],
		;
	}
}
