#
# Puppet has_role() function inspired by Loggly's Truth module
#
# <http://semicomplete.com/presentations/puppet-at-loggly/puppet-at-loggly.pdf.html>
# <https://github.com/loggly/puppet-modules/tree/master/truth>
#     

module Puppet::Parser::Functions
  newfunction(:has_role, :type => :rvalue) do |args|
    Puppet::Parser::Functions.autoloader.loadall

    if (args.is_a? String)
      args = [args]
    end

    role = args[0]

	result = function_extlookup(["roles::".concat(role), ""]).to_i

	function_debug(["has_role(%s): %s" % [role, result]])

    has_role = result > 0

    return has_role
  end
end
