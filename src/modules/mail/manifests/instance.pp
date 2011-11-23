define mail::instance($master, $main, $require = undef) {

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
			require => $require,
		;
		"${queue}":
			ensure  => directory,
			owner   => root,
			group   => root,
			mode    => 0755,
			require => $require,
		;
		"${data}":
			ensure  => directory,
			owner   => postfix,
			group   => postfix,
			mode    => 0755,
			require => $require,
		;
		"${config}/dynamicmaps.cf":
			ensure  => file,
			owner   => root,
			group   => root,
			mode    => 0444,
			content => file("/etc/postfix/dynamicmaps.cf"),
			require => File["/etc/postfix-${name}"],
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