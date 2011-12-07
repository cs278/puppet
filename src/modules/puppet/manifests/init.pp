class puppet {
	include puppet::package
	include git

	file {
		# Headless puppet, so disable the agent service
		"/etc/default/puppet":
			ensure    => file,
			content   => "exit 0\n",
			subscribe => Class["puppet::package"],
		;
	}
}
