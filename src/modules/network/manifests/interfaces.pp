class network::interfaces {
	if extlookup("network::interface::primary::address", "") != "" {
		network::interface::static {
			"10-primary":
				device    => extlookup("network::interface::primary::device", "eth0"),
				ipaddr    => extlookup("network::interface::primary::address"),
				netmask   => extlookup("network::interface::primary::netmask"),
				gateway   => extlookup("network::interface::primary::gateway", ""),
				broadcast => extlookup("network::interface::primary::broadcast", ""),
				auto      => true,
			;
		}
	} else {
		network::interface::dhcp {
			"10-primary":
				device   => extlookup("network::interface::primary::device", "eth0"),
				hostname => extlookup("network::interface::primary::hostname", ""),
				client   => extlookup("network::interface::primary::client", ""),
				auto     => true,
			;
		}
	}
}
