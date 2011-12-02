class mail::package {
	package {
		["postfix", "postfix-cdb", "postfix-pcre"]:
			ensure => latest,
		;
		"swaks":
			ensure => present,
		;
	}

	$apply_fix = $lsbdistcodename ? {
		"natty"    => true,
		"maverick" => true,
		"lucid"    => true,
		"squeeze"  => true,
		"lenny"    => true,
		default    => false,
	}

	if ($apply_fix) {
		file {
			"/etc/init.d/postfix":
				ensure  => present,
				mode    => 0755,
				owner   => root,
				group   => root,
				source  => "puppet:///modules/mail/fixes/init.d",
				replace => true,
			;
		}
	}
}
