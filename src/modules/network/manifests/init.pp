class network {
	$hostname = $::hostname
	$fqdn = $::fqdn

	file {
		"/etc/hosts":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("network/hosts.erb"),
		;
		"/etc/hostname":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => "${hostname}\n",
		;
	}
}
