Facter.add("location") do
	setcode do
		require 'ipaddr'

		kernelrelease = Facter.value('kernelrelease').downcase

		if Facter.value('ec2_public_ipv4')
			ip_public = IPAddr.new Facter.value('ec2_public_ipv4')
		else
			ip_public = IPAddr.new Facter.value('ipaddress_eth0')
		end

		#netname = Facter::Util::Resolution.exec("/usr/bin/whois '%1$s$' | grep -i '^netname:'" % eth0_ip)

		netawseu = IPAddr.new "79.125.0.0/17"
		netlinode = IPAddr.new "178.79.128.0/18"

		#if !netname.empty?
		#	netname = netname.split(':')[1].chop.downcase
		#end

		if kernelrelease.index('linode') != nil || netlinode.include?(ip_public)
			"linode"
		elsif netawseu.include?(ip_public)
			"aws-eu"
		else
			"unknown"
		end
	end
end
