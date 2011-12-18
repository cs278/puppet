Facter.add("region") do
	setcode do
		country = Facter.value('country')

		if country == "gb" || country == "ie"
			"europe"
		else
			"unknown"
		end
	end
end
