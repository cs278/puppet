Facter.add("country") do
	setcode do
		location = Facter.value('location')

		if location == "linode-gb"
			"gb"
		elsif location == "aws-eu"
			"ie"
		else
			"unknown"
		end
	end
end
