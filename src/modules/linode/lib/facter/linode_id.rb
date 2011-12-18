Facter.add("linode_id") do
	setcode do
		require 'json'

		linode = Facter.value('linode')
		hostname = Facter.value('hostname')
		url = "https://api.linode.com/?api_key=7zF3gGscQYx39LgUQpKjiS2F2RyaWRAsf2WuRxPKS5g4MKrrIZHtgFzVmy8EfVKK&api_action=linode.list"

		if linode.to_i == 1
			# Ironic really, it's easier to use wget than net/http (SSL issues)
			response = Facter::Util::Resolution.exec("wget -q -O- '#{url}'")

			linodes = JSON.parse(response)["DATA"].to_a

			linodes.delete_if { |node|
				node["LABEL"].index(hostname) != 0
			}

			linode = linodes.first

			linode["LINODEID"].to_s
		end
	end
end
