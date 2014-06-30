class LineInstance

	attr_accessor :cmd
	attr_accessor :arg1
	attr_accessor :arg2

	def initialize(command, arg1, arg2)
		@cmd = command
		@arg1 = arg1
		@arg2 = arg2
	end

end