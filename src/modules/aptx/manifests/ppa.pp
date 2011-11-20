define aptx::ppa($ensure = present) {
	if $lsbdistid != 'Ubuntu' {
		fail('aptx::ppa() can only be used on Ubuntu.')
	}

	package {
		"python-software-properties":
			ensure => present,
		;
	}

	$filename = gsub($name, '/', '-')
	$file = "/etc/apt/sources.list.d/${filename}-${lsbdistcodename}.list"

	debug($file)

	file {
		"$file":
			ensure  => file,
			require => Exec["$name"],
		;
	}

	exec {
		"$name":
			command => "add-apt-repository ppa:${name}",
			creates => $file,
			notify  => Exec["apt-get_update"],
			require => Package["python-software-properties"],
		;
	}
}
