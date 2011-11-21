class mail::package {
	package {
		["postfix", "postfix-cdb", "postfix-pcre"]:
			ensure => latest,
		;
	}
}
