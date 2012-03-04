class base {
	include base::puppet
	include base::apt
	include base::ca
	include base::gnupg
}
