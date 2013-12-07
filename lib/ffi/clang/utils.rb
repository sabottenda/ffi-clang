
require 'ffi/clang/lib/version'
require 'ffi/clang/lib/string'
module FFI
	module Clang
		class Utils
			def self.clang_version_string
				Lib.extract_string Lib.get_clang_version
			end

			def self.clang_version
				version = clang_version_string
				version.match(/clang version (\d+\.\d+)/)
				$1
			end

			def self.clang_major_version
				version = clang_version_string
				version.match(/clang version (\d+)\./)
				$1.to_i
			end

			def self.clang_minor_version
				version = clang_version_string
				version.match(/clang version \d+\.(\d+)/)
				$1.to_i
			end
		end
	end
end
