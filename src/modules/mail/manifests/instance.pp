define mail::instance() {
	file {
		"/etc/postfix-$name":
			ensure => directory,
			owner  => root,
			group  => root,
			mode   => 0555,
		;
		"/var/spool/postfix-$name":
			ensure => directory,
			owner  => root,
			group  => root,
			mode   => 0750,
		;
		"/var/lib/postfix-$name":
			ensure => directory,
			owner  => postfix,
			group  => postfix,
			mode   => 0700,
		;
		"/etc/postfix-$name/master.cf":
			ensure => file,
			owner  => root,
			group  => root,
			mode   => 0444,
		;
		"/etc/postfix-$name/main.cf":
			ensure => file,
			owner  => root,
			group  => root,
			mode   => 0444,
		;
	}
}
