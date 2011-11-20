class puppet::respository {
	include apt

	apt::key {
		"4BD6EC30":
			source => "http://apt.puppetlabs.com/ubuntu/4BD6EC30.asc",
		;
	}

	$dist = $lsbdistid ? {
		'Debian' => 'debian',
		'Ubuntu' => 'ubuntu',
	}

	apt::sources_list {
		"puppetlabs":
			ensure  => present,
			content => "deb http://apt.puppetlabs.com/${dist} ${lsbdistcodename} main",
			require => Apt::Key["4BD6EC30"],
		;
	}
}
