Facter.add("linode") do
	setcode do
		require 'ipaddr'

		kernelrelease = Facter.value('kernelrelease').downcase

		ip_public = IPAddr.new Facter.value('ipaddress_eth0')

		linode_gb = IPAddr.new "178.79.128.0/18"

		if kernelrelease.index('linode') != nil || linode_gb.include?(ip_public)
			"1"
		else
			"0"
		end
	end
end
