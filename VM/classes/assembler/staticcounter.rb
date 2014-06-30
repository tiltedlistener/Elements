class StaticCounter

	attr_accessor :class
	attr_accessor :counter
	attr_accessor :pointer

	def initialize(name)
		@class = name
		@counter = 0
		@pointer = 16
	end

	def updateSize(num)
		if (num[0].to_i > @counter.to_i)
			@counter = num[0]
		end
	end

end