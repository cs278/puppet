class git::serve inherits git {
	file {
		"/usr/local/bin/git-serve":
			ensure  => file,
			mode    => 0555,
			owner   => root,
			group   => root,
			source  => "puppet:///modules/git/git-serve",
			require => Class["git::package"],
		;
	}
}
