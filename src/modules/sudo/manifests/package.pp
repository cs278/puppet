class sudo::package($ensure=present) {
	package {
		sudo:
			ensure => $ensure,
		;
	}
}
