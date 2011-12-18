define mail::instance::file($path = $name, $instance, $ensure = present, $mode = "", $owner = "", $group = "", $content = "", $source = "", $target = "", $replace = false, $force = false, $recurse = false) {
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
			replace => $replace,
			force   => $force,
			recurse => $recurse,
		;
	}

	if $mode != "" {
		File[$path] {
			mode +> $mode,
		}
	}

	if $owner != "" {
		File[$path] {
			owner +> $owner,
		}
	}

	if $group != "" {
		File[$path] {
			group +> $group,
		}
	}

	if $content != "" {
		File[$path] {
			content +> $content,
		}
	}

	if $source != "" {
		File[$path] {
			source +> $source,
		}
	}

	if $target != "" {
		File[$path] {
			target +> $target,
		}
	}
}
