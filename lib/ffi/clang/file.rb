
require 'ffi/clang/lib/file'

module FFI
	module Clang
		class File < AutoPointer
			def initialize(pointer)
				super pointer
			end
			def self.release(pointer)
			end

			def to_s
				name
			end

			def name
				Lib.extract_string Lib.get_file_name(self)
			end
		end
	end
end
