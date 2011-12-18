class puppet::package {
	include puppet::repository

	package {
		"puppet":
			ensure  => latest,
			require => Class["puppet::repository"],
		;

		$::lsbdistcodename ? {
			"lucid"    => "libjson-ruby",
			"maverick" => "libjson-ruby",
			"natty"    => "libjson-ruby",
			default    => "ruby-json",
		}:
			ensure  => present,
		;
	}
}
