class mail::main($instances = []) {
	include mail::package

	$myhostname = $::fqdn
	$mydomain = "cs278.org"
	$hub = "hub.mail.cs278.org"

	Mail::Instance <| |>

	file {
		"/etc/postfix/main.cf":
			ensure  => present,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/main/main.cf.erb"),
			require => [$instances, Class["mail::package"]],
		;
		"/etc/postfix/generic":
			ensure  => present,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/main/generic.erb"),
			notify  => Exec["postmap cdb:/etc/postfix/generic"],
			require => Class["mail::package"],
		;
		"/etc/postfix/virtual":
			ensure  => present,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("mail/main/virtual.erb"),
			notify  => Exec["postmap cdb:/etc/postfix/virtual"],
			require => Class["mail::package"],
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
