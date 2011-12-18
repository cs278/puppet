class roles::mail {
	$instances = []

	if has_role("mail::gateway") {
		include mail::gateway::commissioned
	} else {
		include mail::gateway::decommissioned
	}

	if has_role("mail::delivery") {
		include mail::delivery::commissioned
	}

	if has_role("mail::frontend") {
		include mail::frontend::commissioned
	}

	include mail::main
}
