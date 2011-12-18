class network::interfaces::config {
	include network::interfaces::setup

	exec {
		"/usr/local/sbin/update-interfaces":
			refreshonly => true,
			require     => Class["network::interfaces::setup"],
		;
	}
}
