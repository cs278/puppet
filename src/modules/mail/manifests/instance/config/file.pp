define mail::instance::config::file($path = $name, $instance, $ensure = present, $mode = "", $owner = "", $group = "", $content = "", $source = "", $target = "", $replace = false, $force = false, $recurse = false) {
	include mail::service

	validate_string($path)
	validate_string($instance)
	validate_string($ensure)
	#validate_int($mode)
	validate_string($owner)
	validate_string($group)
	validate_string($content)
	validate_string($source)
	validate_string($target)
	validate_bool($replace)
	validate_bool($force)

	mail::instance::file {
		"/etc/postfix-${instance}/${path}":
			instance => $instance,
			ensure   => $ensure,
			mode     => $mode,
			owner    => $owner,
			group    => $group,
			content  => $content,
			source   => $source,
			target   => $target,
			replace  => $replace,
			force    => $force,
			recurse  => $recurse,
			require  => Mail::Instance[$instance],
			notify   => Class["mail::service"],
		;
	}
}
