define network::interface::static($device = $name, $ipaddr, $netmask, $gateway = "", $broadcast = "", , $auto = true) {
	include network::interfaces

	file {
		"${name}-${device}":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("network/interface/static.erb"),
			require => Class["network::interfaces"],
		;
	}
}
