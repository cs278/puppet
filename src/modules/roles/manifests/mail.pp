class roles::mail {
	include mail::gateway::commissioned
	include mail::delivery::commissioned

	if has_role("mail::gateway") and has_role("mail::delivery") {
		class {
			"mail::main":
				instances => [
					Class["mail::gateway::commissioned"],
					Class["mail::delivery::commissioned"],
				],
			;
		}
	} elsif has_role("mail::gateway") {
		class {
			"mail::main":
				instances => [
					Class["mail::gateway::commissioned"],
				],
			;
		}
	} elsif has_role("mail::delivery") {
		class {
			"mail::main":
				instances => [
					Class["mail::delivery::commissioned"],
				],
			;
		}
	}
}
