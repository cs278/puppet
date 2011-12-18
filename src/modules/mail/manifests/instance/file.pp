define mail::instance::file($path = $name, $instance, $ensure = present, $mode = 0, $owner = "", $group = "", $content = "", $source = "", $target = "", $replace = false, $force = false) {
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

	file {
		"${path}":
			ensure  => $ensure,
			mode    => $mode,
			owner   => $owner,
			group   => $group,
			replace => $replace,
			force   => $force,
		;
	}

	if $ensure == "symlink" {
		File[$path] {
			target +> $target,
		}
	} elsif $content != "" {
		File[$path] {
			content +> $content,
		}
	} elsif $source != "" {
		File[$path] {
			source +> $source,
		}
	}
}
