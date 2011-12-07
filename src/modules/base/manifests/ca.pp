class base::ca {
	ssl::certificate {
		"ca.cs278.org":
			source => "puppet:///modules/base/ca/cs278.org.crt",
		;
	}
}
