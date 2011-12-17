define mail::instance::config::file($path = $name, $instance, $ensure = present, $mode = 0, $owner = "", $group = "", $content = "", $source = "", $replace = false, $force = false) {
	include mail::service

	validate_string($path)
	validate_string($instance)
	validate_string($ensure)
	#validate_int($mode)
	validate_string($owner)
	validate_string($group)
	validate_string($content)
	validate_string($source)
	validate_bool($replace)
	validate_bool($bool)

	mail::instance::file {
		"/etc/postfix-${instance}/${path}":
			ensure  => $ensure,
			mode    => $mode,
			owner   => $owner,
			group   => $group,
			content => $content,
			source  => $source,
			replace => $replace,
			force   => $force,
			require => Mail::Instance[$instance],
			notify  => Class["mail::service"],
		;
	}
}
