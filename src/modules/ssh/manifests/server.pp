class ssh::server {
	include ssh::server::package
	include ssh::server::allowdeny
	include ssh::server::service

	# Permit root to login but lock it down
	ssh::server::user {
		"root":
			allow  => true,
			config => "
AllowAgentForwarding no
AllowTcpForwarding no
GatewayPorts no
GSSAPIAuthentication no
HostbasedAuthentication no
KbdInteractiveAuthentication no
KerberosAuthentication no
MaxAuthTries 1
PasswordAuthentication no
PermitRootLogin forced-commands-only
PermitTunnel no
PubkeyAuthentication yes
RhostsRSAAuthentication no
RSAAuthentication no
X11Forwarding no
",
		;
	}

	ssh::server::group {
		"ssh":
			allow => true,
		;
	}
}
