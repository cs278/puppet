class mail::opendkim::verifying inherits mail::opendkim {
	File["/etc/opendkim.conf"] {
		content +> template("mail/opendkim/verifying.conf.erb"),
	}
}
