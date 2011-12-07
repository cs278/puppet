define ssl::certificate($ensure = present, $source = "") {
	include ssl::package

	file {
		"/usr/local/share/ca-certificates/${name}.crt":
			ensure  => file,
			owner   => root,
			group   => 0,
			mode    => 0444,
			replace => true,
			source  => $source,
			require => Class["ssl::package"],
			notify  => Exec["update-ca-certificates"],
		;
	}

	exec {
		"update-ca-certificates":
			require     => Class["ssl::package"],
			refreshonly => true,
		;
	}
}
