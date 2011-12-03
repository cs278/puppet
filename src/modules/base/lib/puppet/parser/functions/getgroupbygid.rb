# getgroupbygid(integer) : string
#
# Returns the name of a group with the ID specified
module Puppet::Parser::Functions
	newfunction(:getgroupbygid, :type => :rvalue) do |args|
		%x{getent group #{args[0]}}.split(":").first
	end
end

