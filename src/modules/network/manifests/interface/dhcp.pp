define network::interface::dhcp($device = $name, $hostname = "", $client = "", $auto = true) {
	include network::interfaces

	file {
		"${name}-${device}":
			ensure  => file,
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("network/interface/dhcp.erb"),
			require => Class["network::interfaces"],
		;
	}
}
