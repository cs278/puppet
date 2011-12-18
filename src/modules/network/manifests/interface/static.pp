define network::interface::static($device = $name, $ipaddr, $netmask, $gateway = "", $broadcast = "", , $auto = true) {
	include network::interfaces::setup
	include network::interfaces::config

	file {
		"${name}-${device}":
			ensure  => file,
			path    => "/etc/network/interfaces.d/${name}-${device}",
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("network/interface/static.erb"),
			require => Class["network::interfaces::setup"],
			notify  => Class["network::interfaces::config"],
		;
	}
}
