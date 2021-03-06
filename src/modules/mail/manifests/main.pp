class mail::main {
	include mail::package
	include mail::service
	include mail::main::instances

	if $::ec2_public_hostname {
		$myhostname = $::ec2_public_hostname
	} else {
		$myhostname = $::fqdn
	}
	$mydomain = "cs278.org"
	$hub = "hub.mail.cs278.org"

	file {
		"/etc/postfix/main.cf":
			ensure  => present,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/main/main.cf.erb"),
			require => [Class["mail::main::instances"], Class["mail::package"]],
			notify  => Class["mail::service"],
		;
		"/etc/postfix/generic":
			ensure  => present,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/main/generic.erb"),
			notify  => Exec["postmap cdb:/etc/postfix/generic"],
			require => [Class["mail::main::instances"], Class["mail::package"]],
		;
		"/etc/postfix/virtual":
			ensure  => present,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/main/virtual.erb"),
			notify  => Exec["postmap cdb:/etc/postfix/virtual"],
			require => [Class["mail::main::instances"], Class["mail::package"]],
		;
	}

	exec {
		[
			"postmap cdb:/etc/postfix/generic",
			"postmap cdb:/etc/postfix/virtual",
		]:
			refreshonly => true,
			require     => Class["mail::package"],
		;
	}
}
