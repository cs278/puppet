class mail::delivery::commissioned {
	include mail::delivery::package

	@mail::instance { "delivery":; }
}
