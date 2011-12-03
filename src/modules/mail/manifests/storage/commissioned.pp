class mail::storage::commissioned {
	include mail::storage::package

	$vmail_store = extlookup("mail::storage::store")
	$vmail_uid = extlookup("mail::storage::uid")
	$vmail_gid = extlookup("mail::storage::gid")

	$db_hosts = extlookup("mail::storage::hosts")
	$db_username = extlookup("mail::storage::username")
	$db_password = extlookup("mail::storage::password")
	$db_database = extlookup("mail::storage::database")
}
