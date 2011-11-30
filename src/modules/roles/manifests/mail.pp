class roles::mail {
	if has_role("mail::gateway") and has_role("mail::delivery") {
		include mail::gateway::commissioned
		include mail::delivery::commissioned

		class {
			"mail::main":
				instances => [
					Class["mail::gateway::commissioned"],
					Class["mail::delivery::commissioned"],
				],
			;
		}
	} elsif has_role("mail::gateway") {
		include mail::gateway::commissioned

		class {
			"mail::main":
				instances => [
					Class["mail::gateway::commissioned"],
				],
			;
		}
	} elsif has_role("mail::delivery") {
		include mail::delivery::commissioned

		class {
			"mail::main":
				instances => [
					Class["mail::delivery::commissioned"],
				],
			;
		}
	}
}
