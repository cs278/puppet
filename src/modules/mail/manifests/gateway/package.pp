class mail::gateway::package {
	include mail::package
	include mail::mysql

	package {
		"postfix-policyd-spf-python":
			ensure  => latest,
			require => Class["mail::package"],
		;
#		"greyfix":
#			ensure => latest,
#		;
	}
}
