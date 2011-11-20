class git::package {
	aptx::ppaif {
		"git-core/ppa":;
	}

	package {
		"git":
			ensure  => latest,
			require => Aptx::Ppaif["git-core/ppa"],
		;
	}
}
