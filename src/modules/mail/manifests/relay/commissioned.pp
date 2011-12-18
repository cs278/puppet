class mail::relay::commissioned inherits mail::storage::commissioned  {
	include mail::relay::package

	$interfaces = extlookup("mail::relay::interfaces", "")

	$instance = "relay"

	@mail::instance {
		"${instance}":
			master  => template("mail/${instance}/master.cf.erb"),
			main    => template("mail/${instance}/main.cf.erb"),
			require => [
				Class["mail::${instance}::package"],
			],
		;
	}

	@mail::instance::file {
		"/etc/dovecot/conf.d/10-sasl.conf":
			instance => $instance,
			ensure   => file,
			mode     => 0444,
			owner    => root,
			group    => root,
			content  => template("mail/${instance}/dovecot-sasl.conf.erb"),
	}
}
