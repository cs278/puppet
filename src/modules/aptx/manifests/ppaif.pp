# Add a PPA if system is Ubuntu
#
# This is typically used where we desire the lastest version
# if it is possible to get it, but we don't actually care that much.

define aptx::ppaif($ensure = present) {
	if $::lsbdistid == 'Ubuntu' {
		aptx::ppa {
			"$name":
				ensure => $ensure,
			;
		}
	}
}
