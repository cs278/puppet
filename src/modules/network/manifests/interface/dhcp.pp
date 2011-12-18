define network::interface::dhcp($device = $name, $hostname = "", $client = "", $auto = true) {
	include network::interfaces

	file {
		"${name}-${device}":
			ensure  => file,
			path    => "/etc/network/interfaces.d/${name}-${device}",
			mode    => 0444,
			owner   => root,
			group   => root,
			content => template("network/interface/dhcp.erb"),
			require => Class["network::interfaces"],
			notify  => Class["network::interfaces"],
		;
	}
}
