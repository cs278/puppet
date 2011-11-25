class base::puppet {
	include puppet
	include git
	include git::serve

	# Inspiration for this comes from:
	# * http://current.workingdirectory.net/posts/2011/puppet-without-masters/
	# * http://bitfieldconsulting.com/scaling-puppet-with-distributed-version-control
	# * https://git.mayfirst.org/?p=mfpl/puppet.git;a=summary

	$repo = "/srv/puppet.git"
	$conf = "/etc/puppet"

	exec {
		"${repo}":
			command => "git init --bare ${repo}",
			creates => "${repo}/HEAD",
			user    => puppet,
			group   => puppet,
			require => [Class["git"], File[$repo]],
		;
	}

	file {
		"${repo}":
			ensure  => directory,
			mode    => 0755,
			owner   => puppet,
			group   => puppet,
		;
		"${conf}":
			ensure  => directory,
			mode    => 0755,
			owner   => root,
			group   => root,
		;
		"${conf}/.git":
			ensure  => directory,
			mode    => 0755,
			owner   => root,
			group   => root,
			require => File[$conf],
		;
		"${conf}/.git/hooks":
			ensure  => directory,
			mode    => 0755,
			owner   => root,
			group   => root,
			require => File["${conf}/.git"],
		;
		"${conf}/.git/hooks/post-checkout":
			ensure  => file,
			mode    => 0555,
			owner   => root,
			group   => root,
			content => template("base/puppet/post-checkout.erb"),
			require => File["${conf}/.git/hooks"],
		;
		"${repo}/hooks/post-receive":
			ensure  => file,
			mode    => 0555,
			owner   => root,
			group   => root,
			content => template("base/puppet/post-receive.erb"),
			require => Exec[$repo],
		;
		"/var/lib/puppet/.ssh":
			ensure  => directory,
			mode    => 0700,
			owner   => puppet,
			group   => puppet,
		;
		"/var/lib/puppet/.ssh/authorized_keys":
			ensure  => file,
			mode    => 0400,
			owner   => puppet,
			group   => puppet,
			source  => "puppet:///modules/base/puppet/authorized_keys",
			require => [File["/var/lib/puppet/.ssh"], Class["git::serve"]],
		;
	}
}
