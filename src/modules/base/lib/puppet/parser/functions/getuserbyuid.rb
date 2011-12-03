# getuserbyuid(integer) : string
#
# Returns the username of the user with the ID was specified
module Puppet::Parser::Functions
	newfunction(:getuserbyuid, :type => :rvalue) do |args|
		%x{getent passwd #{args[0]}}.split(":").first
	end
end

