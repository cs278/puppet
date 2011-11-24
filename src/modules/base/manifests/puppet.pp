class base::puppet {
	include puppet
	include git

	# Inspiration for this comes from:
	# * http://current.workingdirectory.net/posts/2011/puppet-without-masters/
	# * http://bitfieldconsulting.com/scaling-puppet-with-distributed-version-control
	# * https://git.mayfirst.org/?p=mfpl/puppet.git;a=summary

	$repo = "/srv/puppet.git"

	exec {
		"${repo}":
			command => "git init --bare ${repo}",
			creates => $repo,
			require => Class["git"],
		;
	}

	file {
		"${repo}/hooks/post-receive":
			ensure  => file,
			mode    => 0555,
			owner   => root,
			group   => root,
			content => template("base/puppet/post-receive.erb"),
			require => Exec[$repo],
		;
	}
}
