
require 'ffi/clang/lib/string'
module FFI
	module Clang
		module Lib
			attach_function :get_clang_version, :clang_getClangVersion, [], CXString.by_value
		end
	end
end
