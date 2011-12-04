class roles::mail {
	$instances = []

	include roles::mail::gateway
	include roles::mail::delivery
	include roles::mail::frontend

	class {
		"mail::main":
			instances => $instances,
		;
	}
}

class roles::mail::gateway {
	if has_role("mail::gateway") {
		include mail::gateway::commissioned

		$roles::mail::instances += Class["mail::gateway::commissioned"]
	}
}

class roles::mail::delivery {
	if has_role("mail::delivery") {
		include mail::delivery::commissioned

		$roles::mail::instances += Class["mail::delivery::commissioned"]
	}
}

class roles::mail::frontend {
	if has_role("mail::frontend") {
		include mail::frontend::commissioned
	}
}
