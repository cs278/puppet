class base::apt {
	# APT please give us automatic updates!
	include apt
	include apt::unattended-upgrade::automatic
}
