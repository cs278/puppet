class linode {
	if $::linode == 1 {
		network::interface::static {
			"linode-private":
				device  => "eth0:1",
				ipaddr  => $::linode_private_ip,
				netmask => "255.255.128.0",
			;
		}
	}
}
