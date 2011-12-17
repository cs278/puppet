define mail::instance::file($path = $name, $instance, $ensure = present, $mode = 0, $owner = "", $group = "", $content = "", $source = "", $replace = false, $force = false) {
	validate_string($path)
	validate_string($instance)
	validate_string($ensure)
	validate_int($mode)
	validate_string($owner)
	validate_string($group)
	validate_string($content)
	validate_string($source)
	validate_bool($replace)
	validate_bool($bool)

	file {
		"${path}":
			ensure  => $ensure,
			mode    => $mode,
			owner   => $owner,
			group   => $group,
			content => $content,
			source  => $source,
			replace => $replace,
			force   => $force,
		;
	}
}
