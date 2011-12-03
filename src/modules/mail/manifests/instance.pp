define mail::instance($master, $main) {

	if ($group == "") {
		$group = $name
	}
	$ident = "postfix-$name"
	$config = "/etc/${ident}"
	$queue = "/var/spool/${ident}"
	$data = "/var/lib/${ident}"
	$domain = "cs278.org"

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
		;
		"${config}/master.cf":
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => 0444,
			content => $master,
			require => File["/etc/postfix-${name}"],
		;
		"${config}/main.cf":
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => 0444,
			content => template("mail/main.instance.cf.erb"),
			require => File["/etc/postfix-${name}"],
		;
	}
}
