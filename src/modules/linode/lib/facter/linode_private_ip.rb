Facter.add("linode_private_ip") do
	setcode do
		begin
			require 'json'

			linode_id = Facter.value('linode_id')
			url = "https://api.linode.com/?api_key=7zF3gGscQYx39LgUQpKjiS2F2RyaWRAsf2WuRxPKS5g4MKrrIZHtgFzVmy8EfVKK&api_action=linode.ip.list&LinodeID=#{linode_id}"

			if !linode_id.empty?
				# Ironic really, it's easier to use wget than net/http (SSL issues)
				response = Facter::Util::Resolution.exec("wget -q -O- '#{url}'")

				ips = JSON.parse(response)["DATA"].to_a

				ips.delete_if { |ip|
					ip["ISPUBLIC"] > 0
				}

				ip = ips.first

				ip["IPADDRESS"].to_s
			end
		rescue LoadError
			""
		end
	end
end
